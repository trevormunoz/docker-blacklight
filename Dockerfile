FROM ubuntu
MAINTAINER Trevor Muñoz <trevor.munoz@gmail.com>
RUN apt-get update
RUN apt-get -y update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install git build-essential libssl-dev libcurl4-openssl-dev autoconf bison libyaml-dev libreadline6 libreadline6-dev zlib1g zlib1g-dev rbenv openjdk-6-jdk solr-jetty nodejs
RUN echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
RUN echo 'eval "$(rbenv init -)"' >> ~/.bashrc
RUN exec $SHELL
RUN mkdir -p $HOME/.rbenv/plugins
RUN cd $HOME/.rbenv/plugins && git clone https://github.com/sstephenson/ruby-build.git
# Until Ruby 2.1.2 w/patched readline6.3 comes out, see: http://stackoverflow.com/a/23155490/1232820
RUN curl -fsSL https://gist.github.com/mislav/a18b9d7f0dc5b9efc162.txt | rbenv install --patch 2.1.1
RUN rbenv global 2.1.1
RUN rbenv rehash
RUN echo "gem: --no-ri --no-rdoc" >> ~/.gemrc
RUN gem install bundler
RUN rbenv rehash
RUN gem install rails
RUN gem install therubyracer
RUN rbenv rehash
RUN rails new blacklightapp
RUN cd $HOME/blacklightapp
RUN echo "gem 'blacklight', '>= 5.3.0'" >> Gemfile
RUN bundle install
RUN rails generate blacklight:install --jettywrapper
RUN rake db:migrate
RUN rails server
EXPOSE 3000