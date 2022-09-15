source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.7.5"
gem "rails", "~> 7.0.2", ">= 7.0.2.3"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false

group :development, :test do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'rspec-rails', '~> 5.1', '>= 5.1.2'
end

group :development do
  gem 'annotate', '~> 3.2'
  gem 'rubocop-rails', '~> 2.12', require: false
end
