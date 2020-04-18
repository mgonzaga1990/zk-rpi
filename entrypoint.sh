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
 
 #create unique id
 mkdir -p ${ZOO_DATA_DIR}
 echo "${ZOO_ID}" > ${ZOO_DATA_DIR}/myid.txt
 mv ${ZOO_DATA_DIR}/myid.txt ${ZOO_DATA_DIR}/myid
else
 echo "No cluster configuration found" 
fi

./$ZOO_PATH/bin/zkServer.sh start

sed -i -e "s/25/1/g" ${ZOO_DATA_DIR}/zookeeper_server.pid
while true
do
  sleep 100
done
