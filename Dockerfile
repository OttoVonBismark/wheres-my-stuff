FROM ruby:3.0.3-alpine3.15

WORKDIR /app

RUN apk --update add \
  bash \
  build-base \
  git \
  nodejs \
  postgresql-dev \
  python2 \
  python3 \
  tzdata \
  yaml-dev \
  yarn \
  zlib-dev

COPY Gemfile* package.json yarn.lock ./

RUN MKFLAGS=-j$(nproc) \
  bundle install && \
  yarn install

COPY . /app

EXPOSE 3000

CMD ["bundle", "exec", "rails", "console"]
