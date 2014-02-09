source 'https://rubygems.org'
ruby '1.9.3'

gem 'rails', '4.0.1'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'nokogiri'
gem 'capybara'
gem 'chronic'
gem 'acts-as-taggable-on'
gem 'poltergeist'
gem 'protected_attributes'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 4.0.0'
  gem 'coffee-rails', '~> 4.0.0'
  gem 'neat'
  gem 'haml', '>= 3.0.0'
  gem 'haml-rails'
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

group :test, :development do
  gem "rspec-rails", "~> 2.0"
  gem 'factory_girl_rails'
  gem 'pry'
  gem 'debugger'
  gem 'sqlite3'
end

group :production do
  gem 'newrelic_rpm'
	gem 'pg'
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
