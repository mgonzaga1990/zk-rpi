FROM ubuntu

MAINTAINER markjayson.gonzaga1990@gmail.com

#install pre-requisites.
RUN apt-get update
RUN apt-get install openjdk-8-jre-headless -y \
    && apt-get install wget -y

#Set ENV variables
ENV ZOO_VERSION=3.4.14
ENV ZOO_HOME=zookeeper
ENV ZOO_FOLDER=zookeeper-${ZOO_VERSION}
ENV ZOO_PATH=${ZOO_HOME}/${ZOO_FOLDER}
ENV ZOO_DATA_DIR=/${ZOO_HOME}/data
ENV PORT=2181
ENV ZOO_ID=

ENV URL=https://apache.osuosl.org/zookeeper/zookeeper-
#Make zookeeper directory
RUN mkdir -p ${ZOO_PATH}

#Download Zookeeper bin
RUN wget -P ${ZOO_PATH}/ ${URL}${ZOO_VERSION}/${ZOO_FOLDER}.tar.gz \
    && tar -xvf ${ZOO_PATH}/${ZOO_FOLDER}.tar.gz -C ${ZOO_HOME} \
    && rm ${ZOO_PATH}/${ZOO_FOLDER}.tar.gz

#COPY myid $ZOO_DATA_DIR
COPY entrypoint.sh /usr/bin
COPY cluster.* /${ZOO_HOME}/

#Make script executable
RUN chmod +x /usr/bin/entrypoint.sh

EXPOSE ${PORT}

#Starting point
CMD /usr/bin/entrypoint.sh
