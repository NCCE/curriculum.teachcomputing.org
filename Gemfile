def next?
  File.basename(__FILE__) == "Gemfile.next"
end

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

gem 'activestorage-validator'
gem 'administrate', '~> 0.17.0'
gem 'administrate-field-active_storage', '~> 0.3.4'
gem 'administrate-field-nested_has_many', '~> 1.3.0'
gem 'aws-sdk-s3', '~> 1.85', require: false
gem 'barnes', '~> 0.0.8'
gem 'bootsnap', '>= 1.4.2', require: false
if next?
  gem 'cloudflare-rails', '~> 2.4'
else
  gem 'cloudflare-rails', '~> 1.1'
end
gem 'faraday', '~> 1.0', '>= 1.0.1'
gem 'graphiql-rails', '1.7.0'
gem 'graphql', '<= 1.10.10'
gem 'lograge', '~> 0.11.2'
gem 'mimemagic', '~> 0.3.7'
gem 'net-imap'
gem 'net-pop'
gem 'net-smtp'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.6'
gem 'rack-attack', '~> 5.4.2'
if next?
  gem 'rails', '~> 7.0.4.3'
else
  gem 'rails', '~> 6.1.7.4'
end
gem 'sass-rails', '>= 6'
gem 'sentry-rails'
gem 'sentry-ruby'
gem 'sidekiq', '~> 7.1'
gem 'webpacker', '~> 5.4.3'


# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

group :development, :test do
  gem 'brakeman'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'climate_control'
  gem 'debase', '>=0.2.5.beta2'
  gem 'dotenv-rails'
  gem 'erb_lint', require: false
  gem 'factory_bot_rails', '~> 5.2.0'
  gem 'guard-rspec', '~> 4.7.3', require: false
  gem 'pry-byebug'
  gem 'rails-erd'
  gem 'next_rails', '~> 1.2' # toolkit to upgrade Rails
  gem 'reek'
  gem 'rspec-mocks'
  gem 'rspec-rails', '~> 4.0.0'
  gem 'rubocop'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
  gem 'ruby-debug-ide', '~> 0.7.3'
  gem 'simplecov'
  gem 'solargraph', '~> 0.39'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'rspec-graphql_matchers'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', '~> 3.1'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end
