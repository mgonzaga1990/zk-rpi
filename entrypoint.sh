#!/bin/sh
set -e

#Create Update zoo.cfg
zoo_file=${ZOO_PATH}/conf/zoo.cfg
printf "tickTime=2000\ninitLimit=10\ndataDir=${ZOO_DATA_DIR}\nclientPort=${PORT}\n" > $zoo_file

#Update server config
cluster_file=/${ZOO_HOME}/cluster.properties
echo "checking config path from : ${cluster_file}"
if [ -f "$cluster_file" ]; then
 echo "ZOOKEEPER Cluster config found"
 while IFS='=' read -r key value
 do
 echo "${key} ${value}" 
  printf "server.${key}=${value}\n" >> $zoo_file
 done < "${ZOO_HOME}/cluster.properties"
else
 echo "No cluster configuration found" 
fi

./$ZOO_PATH/bin/zkServer.sh start

while true
do
  sleep 100
done
