FROM ubuntu
MAINTAINER Trevor Muñoz <trevor.munoz@gmail.com>
RUN apt-get update
RUN apt-get -y update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install git curl build-essential libssl-dev libcurl4-openssl-dev autoconf bison libyaml-dev libreadline6 libreadline6-dev zlib1g zlib1g-dev rbenv nodejs