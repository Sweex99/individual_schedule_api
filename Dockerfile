ARG RUBY_VERSION=3.3.4
ARG VARIANT=jemalloc-bullseye-slim
FROM ruby:3.3.4-alpine

ARG USER_ID
ARG GROUP_ID

RUN apk --update --no-cache add \
  build-base \
  bash \
  libpq-dev \
  postgresql-client \
  postgresql-dev \
  tzdata \
  git \
  libxml2-dev \
  libxslt-dev \
  libc6-compat \
  less \
  imagemagick \
  libwebp-dev

RUN mkdir /app
WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN gem install bundler
RUN gem install byebug
RUN bundle install --jobs 4

COPY . .

EXPOSE 3001

