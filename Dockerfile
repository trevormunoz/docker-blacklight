# VERSION 0.1.0
FROM ubuntu:12.04

MAINTAINER Trevor Muñoz "https://twitter.com/trevormunoz"

RUN DEBIAN_FRONTEND=noninteractive apt-get -y update &&\
    apt-get -y install python-software-properties curl \
                       build-essential git wget libxslt-dev \
                       libcurl4-openssl-dev libssl-dev \
                       libyaml-dev libtool libxml2-dev \
                       libsqlite3-dev openjdk-7-jdk &&\
    echo 'gem: --no-document' >> /usr/local/etc/gemrc &&\
    mkdir /src && cd /src &&\
    git clone https://github.com/sstephenson/ruby-build.git &&\
    cd /src/ruby-build && ./install.sh &&\
    cd / && rm -rf /src/ruby-build && ruby-build 2.0.0-p451 /usr/local &&\
    gem update --system &&\
    gem install bundler &&\
    cd /src && mkdir solr && cd /src/solr &&\
    wget http://mirrors.gigenet.com/apache/lucene/solr/4.8.0/solr-4.8.0.tgz &&\
    tar -xzvf solr-4.8.0.tgz && cd solr-4.8.0/example &&\
    java -jar start.jar
EXPOSE 8983
