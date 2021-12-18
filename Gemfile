# frozen-string-literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.3'

gem 'bootsnap', require: false
gem 'cssbundling-rails'
gem 'devise'
gem 'haml-rails'
gem 'jbuilder'
gem 'jsbundling-rails'
gem 'pg'
gem 'puma', '~> 5.0'
gem 'rails', '~> 7.0.0'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'turbo-rails'

# Use Sass to process CSS
# gem "sassc-rails"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  gem 'brakeman'
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-rails'
end

group :development do
  gem 'rack-mini-profiler'
  gem 'rubocop'
  gem 'solargraph'
  gem 'web-console'
  gem 'yard'
end

group :test do
  gem 'capybara'
  gem 'fuubar'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end
