source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.6.6'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.1.0'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 6.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

gem 'httparty'
gem 'jquery-rails'
gem "webpacker"

# User control and authorization
gem 'devise'
gem "pundit"

# For background jobs
gem 'sidekiq'
gem 'sidekiq-scheduler'
gem 'redis'

# To read mp3 metadata
gem 'id3tag', '~> 0.11.0'

# Styling
gem 'bootstrap', '~> 4.3.1'

# Mailchimp integration
gem 'gibbon'

# ENV config
gem 'figaro'

# Files upload
gem 'shrine', '~> 2.11'
gem 'aws-sdk-s3'
gem 'aws-sdk-elastictranscoder'
gem 'ffprober'
gem 'uppy-s3_multipart', '~> 0.2'
gem 'image_processing', '~> 1.0'

# Get client timezones
gem 'browser-timezone-rails'

# Pagination
gem 'will_paginate', '~> 3.1.7'

# Monitoring
gem 'scout_apm'

# Caching
gem 'dalli'

# RSS feed parsing
gem 'feedjira'

# Error reporting
gem 'sentry-raven'

# User agent parsing
gem 'device_detector'
gem 'geocoder'

# Data viz
gem 'chartkick'
gem 'groupdate'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  # gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'pry'
  gem 'selenium-webdriver'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  gem 'faker'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
