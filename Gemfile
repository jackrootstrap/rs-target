# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.5'
gem 'bootsnap', require: false
gem 'devise_token_auth', '~> 1.2.1'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.2', '>= 7.0.2.3'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails', '~> 6.2'
  gem 'faker', '~> 1.6', '>= 1.6.6'
  gem 'rspec_api_documentation', '~> 6.1.0'
  gem 'rspec-json_expectations', '~> 2.2.0'
  gem 'rspec-rails', '~> 5.1', '>= 5.1.2'
end

group :development do
  gem 'annotate', '~> 3.2'
  gem 'brakeman', '~> 5.3', '>= 5.3.1'
  gem 'reek', '~> 6.1', '>= 6.1.1'
  gem 'rubocop-rails', '~> 2.12', require: false
end
