FROM ruby:2.6.6-alpine
RUN apk --no-cache add build-base curl postgresql-dev tzdata nodejs chromium chromium-chromedriver yarn
RUN mkdir /app
WORKDIR /app

COPY .ruby-version /app/.ruby-version

COPY Gemfile-base /app
COPY Gemfile-base.lock /app
RUN bundle install --gemfile=Gemfile-base

COPY Gemfile /app
COPY Gemfile.lock /app
RUN bundle install

COPY package.json yarn.lock ./
RUN yarn install
COPY . /app
CMD ./scripts/docker-entrypoint.sh
