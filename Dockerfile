FROM ubuntu

RUN apt-get update \
    && apt-get install default-jdk -y

RUN apt-get install wget -y

RUN mkdir /zookeeper

WORKDIR zookeeper

ENV ZOO_HOME=apache-zookeeper-3.6.0-bin

RUN wget https://downloads.apache.org/zookeeper/zookeeper-3.6.0/apache-zookeeper-3.6.0-bin.tar.gz \
  && tar -xvf apache-zookeeper-3.6.0-bin.tar.gz

COPY entrypoint.sh /usr/bin

COPY zoo.cfg /zookeeper/apache-zookeeper-3.6.0-bin/conf

RUN chmod +x /usr/bin/entrypoint.sh

CMD /usr/bin/entrypoint.sh
