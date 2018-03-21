FROM ruby:2.4

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ADD . /usr/src/app
RUN bundle install --system

COPY database.yml /database.yml

EXPOSE 3000

CMD ["bin/fake_sqs", "-p", "3000", "--no-daemonize", "--database", "/database.yml"]
