#!/bin/bash
#Configuration
BACKUP_PATH=/mnt/example
#Script
docker ps --format {{.Names}} > dockerpsNames
docker ps -q > dockerps
LINE_COUNT=$(wc -l < dockerps)
for (( c=1; c<=$LINE_COUNT; c++))
  do
    ID=$(sed $c'q;d' dockerps)
    NAMES=$(sed $c'q;d' dockerpsNames)
    docker export $ID  > $BACKUP_PATH/$ID.tar
    mv $BACKUP_PATH/$ID.tar $BACKUP_PATH/$NAMES"_"$ID.tar
  done
rm -rf dockerps
rm -rf dockerpsNames

echo "Backup all running dockers done, now You can import yours dockers by command: docker import $BACKUP_PATH/example.tar
