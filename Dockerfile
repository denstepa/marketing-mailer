FROM ruby:2.5.3

MAINTAINER Denis Stepanov <denstepa@gmail.com>

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev vim git postgresql-client nodejs yarn

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
ADD . $APP_HOME

RUN gem install bundler && bundle install --jobs 20 --retry 5

ENTRYPOINT ["bundle", "exec"]
