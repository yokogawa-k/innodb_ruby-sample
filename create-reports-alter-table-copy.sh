#!/bin/bash

set -u

export TERM="xterm-256color"
TARGET_INNODB_FILE=/var/lib/mysql/demo/demo1.ibd

function wait_connect() {
  while :; do
    docker exec mysql mysql -Ne 'select version()'
    if [[ $? -eq 0 ]]; then
      break
    fi
    sleep 1
  done
}

function wait_flush() {
  while :; do
    DIRTY_PAGES=$(docker exec mysql mysql -Ne 'SHOW GLOBAL STATUS like "Innodb_buffer_pool_pages_dirty"' | awk '{print $2}')
    if [[ ${DIRTY_PAGES} -eq 0 ]]; then
      break
    else
      sleep 1
    fi
  done
}

function setup_mysql() {
  docker-compose pull
  docker-compose up -d
  echo "Import initial data"
  while :; do
    docker exec innodb_ruby test -f ${TARGET_INNODB_FILE}
    if [[ $? -eq 0 ]]; then
      break
    fi
    echo "waiting..."
    sleep 2
  done
}

function save_svg() {
  local PREFIX=$1
  SVG_FILE="${SVG_DIR}/${PREFIX}.svg"
  SVG_URL="https://rawgit.com/yokogawa-k/innodb_ruby-sample/master/${SVG_DIR}/${PREFIX}.svg"
  docker exec innodb_ruby innodb_space -f ${TARGET_INNODB_FILE} space-extents-illustrate-svg >${SVG_FILE}
  echo >> ${OUTPUT_FILE}
  echo "<img src='${SVG_URL}' width='150%'>" >>${OUTPUT_FILE}
  echo >> ${OUTPUT_FILE}
}

function check_inode_change() {
  local BEFORE=$1
  local AFTER=$2
  echo >> ${OUTPUT_FILE}
  if [[ $1 -ne $2 ]]; then
    echo "**Inode changed** (file copied)" >> ${OUTPUT_FILE}
  else
    echo "Inode Not changed" >> ${OUTPUT_FILE}
  fi
}

docker-compose down -v

BASE_DIR="./report-alter-table-copy"
SVG_DIR="${BASE_DIR}/svg"
OUTPUT_FILE="${BASE_DIR}/README.md"
mkdir -p "${SVG_DIR}"
echo "## ALTER TABLE demo1 ENGINE=INNODB, ALGORITHM=COPY" > ${OUTPUT_FILE}

#for i in 5.5.{46..59} 5.6.{27..39} 5.7.{9..21}; do
for i in 5.6.{27..39} 5.7.{9..21}; do
  export VERSION=${i}
  echo "## MySQL ${VERSION}" >> ${OUTPUT_FILE}
  setup_mysql
  
  set -x
  wait_connect
  wait_flush

  QUERY='DELETE FROM demo1 WHERE id1 BETWEEN 3001 AND 4000'
  docker exec mysql mysql demo -e "${QUERY}"
  wait_flush
  
  docker exec mysql bash -c 'mysql demo < /work/demo1_insert_11001_to_21000.sql'
  wait_flush

  alter_check 
  echo >> ${OUTPUT_FILE}
  echo "### ${VERSION}" >> ${OUTPUT_FILE}
  BEFORE_INODE=$(docker exec mysql stat -c %i ${TARGET_INNODB_FILE})
  BEFORE_SIZE=$(docker exec mysql stat -c %s ${TARGET_INNODB_FILE})
  docker exec mysql mysql demo -e "ALTER TABLE demo1 ENGINE=INNODB, ALGORITHM=COPY"
  wait_flush
  AFTER_INODE=$(docker exec mysql stat -c %i ${TARGET_INNODB_FILE})
  AFTER_SIZE=$(docker exec mysql stat -c %s ${TARGET_INNODB_FILE})
  check_inode_change BEFORE_INODE AFTER_INODE
  echo "size: ${BEFORE_SIZE} => ${AFTER_SIZE}" >> ${OUTPUT_FILE}
  save_svg ${VERSION}
  
  docker-compose down -v
  
  set +x
done
