FROM ruby:3.0.3

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-utils \
    default-mysql-client \
    tzdata \
    nodejs \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /var/tmp/*

# Install yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo 'deb http://dl.yarnpkg.com/debian/ stable main' > /etc/apt/sources.list.d/yarn.list \
    && apt-get update \
    && apt-get install -y yarn

# Set environement variables
ENV RAILS_ENV production
ENV RAILS_SERVE_STATIC_FILES true

# Install gems
COPY Gemfile* /tmp/
WORKDIR /tmp
RUN gem install bundler \
    && bundle config set without 'development test' \
    && bundle install --jobs 20 --retry 5

# Add app code
ENV app /atlas
RUN mkdir $app
WORKDIR $app
COPY . $app

# Add container startup commands file
COPY .docker/production/docker-entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

# Precompile assets
RUN bundle exec rake assets:precompile

# Specify app port
EXPOSE 3000

# Start the main process
CMD ["rails", "server", "-b", "0.0.0.0"]
