FROM ruby:2.7

ENV LC_ALL=C.UTF-8 \
    LANG=C.UTF-8

WORKDIR /site

RUN apt-get update && apt-get install -y \
    build-essential \
    libxml2-dev \
    libxslt1-dev \
    zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

# Bundler compatibile con Ruby 2.7 e GitHub Pages
RUN gem install bundler -v "2.3.26"

COPY Gemfile Gemfile.lock* ./

RUN bundle config set path "/gems" && \
    bundle install

COPY . .

EXPOSE 4000

CMD ["bundle", "exec", "jekyll", "serve", "--host", "0.0.0.0", "--livereload"]

