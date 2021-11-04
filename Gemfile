source 'https://rubygems.org'

ruby '2.6.6'
gem 'rails', '4.2.11'

# for Heroku deployment - as described in Ap. A of ELLS book
group :development, :test do
  gem 'byebug'
  gem 'database_cleaner'
  gem 'capybara'
  gem 'launchy'
  gem 'rspec-rails'
  gem 'pry'
  gem 'pry-byebug'
  gem 'sqlite3', '~> 1.3.6'
end

group :test do
  gem 'cucumber-rails', require: false
  gem 'cucumber-rails-training-wheels'
  gem 'simplecov', :require => false
end
group :production do
  gem 'pg', '~> 0.21' # for Heroku deployment
  gem 'rails_12factor'
end

# Gems used only for assets and not required
# in production environments by default.

gem 'sass-rails', '~> 5.0.3'
gem 'coffee-rails', '~> 4.1.0'
gem 'uglifier', '>= 2.7.1'

gem 'jquery-rails'
gem 'haml'
gem 'protected_attributes'

# gem 'sqlite3', '~> 1.3.0'
