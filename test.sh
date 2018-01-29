#!/bin/bash

set -u

export TERM="xterm-256color"
TARGET_INNODB_FILE=/var/lib/mysql/demo/demo1.ibd

function setup_mysql() {
  docker-compose pull
  docker-compose up -d
  echo "Import initial data"
  while :; do
    docker-compose exec innodb_ruby test -f ${TARGET_INNODB_FILE}
    if [[ $? -eq 0 ]]; then
      break
    fi
    echo "waiting..."
    sleep 2
  done
}


docker-compose down -v

for i in {5,6,7};do
  export VERSION=5.${i}
  setup_mysql

  set -x
  sleep 2
  docker-compose exec mysql mysql -e 'select version()'
  docker-compose exec innodb_ruby innodb_space -f ${TARGET_INNODB_FILE}  space-extents-illustrate

  docker-compose exec mysql mysql demo -e 'DELETE FROM demo1 WHERE id1 BETWEEN 3001 AND 4000'
  sleep 10
  docker-compose exec innodb_ruby innodb_space -f ${TARGET_INNODB_FILE}  space-extents-illustrate
  
  docker-compose exec mysql bash -c 'mysql demo < /work/demo1_insert_10001_to_11000.sql'
  sleep 10
  docker-compose exec innodb_ruby innodb_space -f ${TARGET_INNODB_FILE}  space-extents-illustrate
  
  docker-compose exec mysql bash -c 'mysql demo < /work/demo1_insert_3001_to_4000.sql'
  sleep 10
  docker-compose exec innodb_ruby innodb_space -f ${TARGET_INNODB_FILE}  space-extents-illustrate

  docker-compose exec mysql bash -c 'mysql demo < /work/demo1_insert_11001_to_21000.sql'
  sleep 10
  docker-compose exec innodb_ruby innodb_space -f ${TARGET_INNODB_FILE}  space-extents-illustrate


  docker-compose exec mysql stat ${TARGET_INNODB_FILE}
  docker-compose exec mysql bash -c 'mysql demo -e "ALTER TABLE demo1 ENGINE=INNODB"'
  sleep 10
  docker-compose exec mysql stat ${TARGET_INNODB_FILE}
  docker-compose exec innodb_ruby innodb_space -f ${TARGET_INNODB_FILE}  space-extents-illustrate

  if [[ ${VERSION} =~ ^5.5 ]]; then
    :
  else
    docker-compose exec mysql stat ${TARGET_INNODB_FILE}
    docker-compose exec mysql bash -c 'mysql demo -e "ALTER TABLE demo1 ENGINE=INNODB, ALGORITHM=COPY"'
    sleep 10
    docker-compose exec mysql stat ${TARGET_INNODB_FILE}
    docker-compose exec innodb_ruby innodb_space -f ${TARGET_INNODB_FILE}  space-extents-illustrate
  fi

  docker-compose exec mysql stat ${TARGET_INNODB_FILE}
  docker-compose exec mysql bash -c 'mysql demo -e "OPTIMIZE TABLE demo1"'
  sleep 10
  docker-compose exec mysql stat ${TARGET_INNODB_FILE}
  docker-compose exec innodb_ruby innodb_space -f ${TARGET_INNODB_FILE}  space-extents-illustrate

  docker-compose exec mysql stat ${TARGET_INNODB_FILE}
  docker-compose exec mysql bash -c 'mysql demo -e "ALTER TABLE demo1 ENGINE=INNODB, FORCE"'
  sleep 10
  docker-compose exec mysql stat ${TARGET_INNODB_FILE}
  docker-compose exec innodb_ruby innodb_space -f ${TARGET_INNODB_FILE}  space-extents-illustrate

  docker-compose down -v

  set +x
done
