FROM bitnami/redmine:latest
RUN apt-get update
#NOKOGIRI INSTALL
RUN apt-get install build-essential patch ruby-dev zlib1g-dev liblzma-dev -y
#PG INSTALL
RUN apt-get install postgresql-client libpq5 libpq-dev -y
#MAGICK INSTALL
RUN apt-get install libmagick++-dev -y

# RUN sed -i "s/interwiki'] = ''/interwiki'] = 'extern_tab'/g" opt/bitnami/dokuwiki/conf/dokuwiki.php

RUN apt-get install -y git
RUN git clone https://github.com/IremBeles/redmine-dockerfile.git
#sudo cp redmine-dockerfile/redmine_agile/ /opt/bitnami/redmine/plugins/ -r

# bundle install --without development test postgresql sqlite --no-deployment

# bundle install --without development test postgresql sqlite --deployment

# bundle exec rake redmine:plugins RAILS_ENV=production
