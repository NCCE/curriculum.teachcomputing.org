source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.1'

gem 'administrate', '~> 0.13.0'
gem 'administrate-field-active_storage', '~> 0.3.4'
gem 'aws-sdk', '~> 3'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'ddtrace', '~> 0.18.2'
gem 'graphiql-rails', '1.7.0'
gem 'graphql', '~> 1.10.10'
gem 'lograge', '~> 0.11.2'
gem 'pg', '~> 1.1'
gem 'puma', '~> 4.3'
gem 'rails', '~> 6.0.3'
gem 'sass-rails', '>= 6'
gem 'sentry-raven', '~> 3.0.0'
gem 'webpacker', '~> 4.0'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

group :development, :test do
  gem 'brakeman'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'dotenv-rails'
  gem 'erb_lint', require: false
  gem 'factory_bot_rails', '~> 5.2.0'
  gem 'guard-rspec', '~> 4.7.3', require: false
  gem 'pry-byebug'
  gem 'reek'
  gem 'rspec-mocks'
  gem 'rspec-rails', '~> 4.0.0'
  gem 'rubocop'
  gem 'rubocop-rspec'
  gem 'simplecov'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'debase'
  gem 'fuzzy-string-match'
  gem 'listen', '~> 3.2'
  gem 'ruby-debug-ide'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
  gem 'rubyzip'
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
