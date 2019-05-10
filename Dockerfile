FROM bitnami/redmine:3.4.7-debian-9-r2
RUN apt-get update
#NOKOGIRI INSTALL REDMINE-AGILE CONF
RUN apt-get install build-essential patch ruby-dev zlib1g-dev liblzma-dev -y
#PG INSTALL REDMINE-AGILE CONF
RUN apt-get install postgresql-client libpq5 libpq-dev -y
#MAGICK INSTALL REDMINE-AGILE CONF
RUN apt-get install libmagick++-dev -y
RUN sed -i "s/adapter: mysql2/adapter: postgresql/g" /opt/bitnami/redmine/config/database.yml
#GIT CONFIGURATION
RUN apt-get install -y git
RUN git clone https://github.com/IremBeles/redmine-dockerfile.git
#REDMINE-AGILE INSTALL
RUN sudo cp redmine-dockerfile/redmine_agile/ /opt/bitnami/redmine/plugins/ -r
#REDMINE-CHECKLIST INSTALL
RUN sudo cp redmine-dockerfile/redmine_checklists/ /opt/bitnami/redmine/plugins/ -r
#PurpleMine2 Theme INSTALL
RUN sudo cp redmine-dockerfile/PurpleMine2-2.2.0/ /opt/bitnami/redmine/public/themes/ -r
#SETTINGS CHANGE
RUN sed -i "32s/.*/  default: '0'/" /opt/bitnami/redmine/config/settings.yml
RUN sed -i "254s/.*/  default: 'PurpleMine2-2.2.0'/" /opt/bitnami/redmine/config/settings.yml
#RUN BUNDLE_GEMFILE="/opt/bitnami/redmine/Gemfile" bundle install --no-deployment
RUN BUNDLE_GEMFILE="/opt/bitnami/redmine/Gemfile" bundle install --without development test postgresql sqlite --no-deployment
RUN BUNDLE_GEMFILE="/opt/bitnami/redmine/Gemfile" bundle install --without development test postgresql sqlite --deployment
#RUN BUNDLE_GEMFILE="/opt/bitnami/redmine/Gemfile" bundle exec rake -f /opt/bitnami/redmine/Rakefile redmine:plugins RAILS_ENV=production
#RUN BUNDLE_GEMFILE="/opt/bitnami/redmine/Gemfile" bundle exec rake -f /opt/bitnami/redmine/Rakefile redmine:plugins NAME=redmine_agile RAILS_ENV=production
