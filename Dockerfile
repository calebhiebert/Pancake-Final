FROM ruby:2.3

RUN mkdir -p /usr/src/app
RUN mkdir -p /usr/src/app/public/uploads
WORKDIR /usr/src/app

RUN apt-get update && apt-get install -y nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install -y mysql-client postgresql-client sqlite3 --no-install-recommends && rm -rf /var/lib/apt/lists/*
COPY Gemfile .
COPY Gemfile.lock .

RUN bundle install

COPY . .
RUN rake db:create && rake db:migrate && rake db:seed

EXPOSE 3000

CMD ["rails", "server"]