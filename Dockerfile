FROM ubuntu
MAINTAINER Trevor Muñoz <trevor.munoz@gmail.com>
RUN apt-get update
RUN apt-get -y update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install git curl build-essential libssl-dev libcurl4-openssl-dev autoconf bison libyaml-dev libreadline6 libreadline6-dev zlib1g zlib1g-dev rbenv nodejs

RUN curl -L ftp://ftp.ruby-lang.org/pub/ruby/2.1/ruby-2.1.1.tar.bz2 | tar -xj -C /tmp
RUN cd /tmp/ruby-2.1.1 && ./configure --disable-install-doc && make install clean
RUN gem update --system
RUN rm -r /tmp/ruby-2.1.1