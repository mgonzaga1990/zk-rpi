FROM ubuntu

MAINTAINER markjayson.gonzaga1990@gmail.com

#install pre-requisites.
RUN apt-get update
RUN apt-get install openjdk-8-jre-headless -y \
    && apt-get install wget -y

#Set ENV variables
ENV ZOO_VERSION=3.6.0
ENV ZOO_HOME=zookeeper
ENV ZOO_FOLDER=apache-zookeeper-${ZOO_VERSION}-bin
ENV ZOO_PATH=${ZOO_HOME}/${ZOO_FOLDER}
ENV ZOO_DATA_DIR=/${ZOO_HOME}/var
ENV PORT=2181

#Make zookeeper directory
RUN mkdir -p ${ZOO_PATH}

#Download Zookeeper bin
RUN wget -P ${ZOO_PATH}/ https://downloads.apache.org/zookeeper/zookeeper-${ZOO_VERSION}/${ZOO_FOLDER}.tar.gz \
    && tar -xvf ${ZOO_PATH}/${ZOO_FOLDER}.tar.gz -C ${ZOO_HOME} \
    && rm ${ZOO_PATH}/${ZOO_FOLDER}.tar.gz

COPY entrypoint.sh /usr/bin
COPY cluster.proper* /${ZOO_HOME}/

#Make script executable
RUN chmod +x /usr/bin/entrypoint.sh

EXPOSE ${PORT}

#Starting point
CMD /usr/bin/entrypoint.sh
