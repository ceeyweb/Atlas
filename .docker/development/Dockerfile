FROM ruby:2.7.0

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
ENV RAILS_ENV development
ENV RAILS_SERVE_STATIC_FILES false

# Install gems
COPY Gemfile* /tmp/
WORKDIR /tmp
RUN gem install bundler && bundle install --retry 5

# Add app code
ENV app /atlas
RUN mkdir $app
WORKDIR $app
COPY . $app

# Install dependencies
RUN yarn install

# Add container startup commands file
COPY .docker/development/docker-entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]

# Specify app port
EXPOSE 3000

# Start the main process
CMD ["rails", "server", "-b", "0.0.0.0"]
