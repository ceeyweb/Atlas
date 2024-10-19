# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.3"

gem "bcrypt",              "~> 3.1.20"
gem "bootsnap",            ">= 1.4.2", require: false
gem "jbuilder",            "~> 2.7"
gem "mysql2",              ">= 0.4.4"
gem "puma",                "~> 5.0"
gem "rails",               "~> 6.1.0"
gem "sass-rails",          ">= 6"
gem "social-share-button", "1.2.4"
gem "terser",              "~> 1.2.5"
gem "turbolinks",          "~> 5"
gem "webpacker",           "~> 5.0"

group :development, :test do
  gem "byebug", platforms: %i[mri mingw x64_mingw]
end

group :development do
  gem "listen",                ">= 3.0.5", "< 3.2"
  gem "rubocop-performance"
  gem "rubocop-rails"
  gem "spring",                "2.1.0"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console",           ">= 3.3.0"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "selenium-webdriver"
  gem "webdrivers"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
