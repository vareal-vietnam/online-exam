source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.6.3"

gem "rails", "~> 5.2.3"
gem "mysql2", ">= 0.4.4", "< 0.6.0"
gem "puma", "~> 4.3"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.2"
gem "turbolinks", "~> 5"
gem "jbuilder", "~> 2.5"
gem "bootsnap", ">= 1.1.0", require: false
gem "figaro", "~> 1.1", ">= 1.1.1"
gem "bcrypt"
gem "jquery-rails"
gem "will_paginate"
gem "bootstrap-will_paginate"
gem "bootstrap-sass", "3.4.1"
gem "faker"
gem "font-awesome-rails"
gem "config"
gem "paranoia"
gem "cocoon"
gem "rubocop", "~> 0.72.0", require: false
gem "jquery-countdown-rails"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "rspec-rails", "~> 3.8"
end

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "selenium-webdriver"
  gem "chromedriver-helper"
  gem "shoulda-matchers"
  gem "rails-controller-testing"
  gem "factory_bot_rails"
  gem "simplecov"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
