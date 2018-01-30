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
  SVG_FILE="./${VERSION}/${PREFIX}.svg"
  docker exec innodb_ruby innodb_space -f ${TARGET_INNODB_FILE} space-extents-illustrate-svg >${SVG_FILE}
  echo "![${PREFIX}](${SVG_FILE})" >> ${OUTPUT_FILE}
}

function check_inode_change() {
  local BEFORE=$1
  local AFTER=$2
  if [[ $1 -ne $2 ]]; then
    echo "Inode changed (file copied)" >> ${OUTPUT_FILE}
  else
    echo "Inode **Not** changed" >> ${OUTPUT_FILE}
  fi
}

function alter_check() {
  local QUERY=$1
  local SVG_FILE=$(echo ${QUERY} | sed -e 's/.*/\L&/' -e 's/[ ,=]/_/g' -e 's/_\+/_/g')
  echo "## ${QUERY}" >> ${OUTPUT_FILE}
  BEFORE_INODE=$(docker exec mysql stat -c %i ${TARGET_INNODB_FILE})
  docker exec mysql mysql demo -e "${QUERY}"
  wait_flush
  save_svg ${SVG_FILE}
  AFTER_INODE=$(docker exec mysql stat -c %i ${TARGET_INNODB_FILE})
  check_inode_change BEFORE_INODE AFTER_INODE
}

docker-compose down -v

cd ./report
for i in {5,6,7}; do
  export VERSION=5.${i}
  OUTPUT_FILE="${VERSION}.md"
  if [[ -f ${OUTPUT_FILE} ]]; then
    break
  fi
  mkdir -p ${VERSION}
  echo "# MySQL ${VERSION}" > ${OUTPUT_FILE}
  setup_mysql
  
  set -x
  wait_connect
  wait_flush

  echo "## Initial Usage" >> ${OUTPUT_FILE}
  echo "demo1 tables has id1 1 to 10000" >> ${OUTPUT_FILE}
  save_svg init
  
  QUERY='DELETE FROM demo1 WHERE id1 BETWEEN 3001 AND 4000'
  echo "## ${QUERY}" >> ${OUTPUT_FILE}
  docker exec mysql mysql demo -e "${QUERY}"
  wait_flush
  save_svg delete_3001_to_4000
  
  echo "## INSERT 10001 to 11000" >> ${OUTPUT_FILE}
  docker exec mysql bash -c 'mysql demo < /work/demo1_insert_10001_to_11000.sql'
  wait_flush
  save_svg insert_10001_to_11000

  echo "## INSERT 3001 to 4000" >> ${OUTPUT_FILE}
  docker exec mysql bash -c 'mysql demo < /work/demo1_insert_3001_to_4000.sql'
  wait_flush
  save_svg insert_3001_to_4000

  echo "## INSERT 11001 to 21000" >> ${OUTPUT_FILE}
  docker exec mysql bash -c 'mysql demo < /work/demo1_insert_11001_to_21000.sql'
  wait_flush
  save_svg insert_11001_to_21000

  alter_check "ALTER TABLE demo1 ENGINE=INNODB"

  if [[ ${VERSION} =~ ^5.5 ]]; then
    :
  else
    alter_check "ALTER TABLE demo1 ENGINE=INNODB, ALGORITHM=COPY"
  fi

  alter_check "OPTIMIZE TABLE demo1"

  alter_check "ALTER TABLE demo1 ENGINE=INNODB, FORCE"
  
  docker-compose down -v
  
  set +x
done
