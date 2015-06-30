source 'https://rubygems.org'

ruby '2.2.0'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.2'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0.1'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 2.7.1'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby
# Use haml
gem 'haml'
gem 'less-rails'
gem 'therubyracer'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.2.8'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.1',          group: :doc
#gem 'foundation-rails', '5.4.3.1'
gem 'twitter-bootstrap-rails', :git => 'git://github.com/seyhunak/twitter-bootstrap-rails.git'
gem 'simple_form'

gem 'awesome_print', git: 'https://github.com/michaeldv/awesome_print'
gem "mongoid", "~> 4.0.0"
gem 'devise'
gem 'mongoid_search'
gem 'will_paginate_mongoid'
gem 'cancancan', '~> 1.10.1'


group :development do
  gem 'haml-rails' # only in dev, because haml-rails adds the generators
  gem 'quiet_assets'
  gem 'rails_layout'
  gem 'bullet'
  # gems for inspecting code qualitty
  gem 'i18n-tasks', '~> 0.7.12'
  gem 'inch', require: false
  gem 'rubocop', require: false
  gem 'rubycritic', require: false
  gem 'brakeman-min', require: false
end

group :development, :test do
  gem 'jazz_hands', github: 'jkrmr/jazz_hands'
end

group :test do
  # [ERROR] The 'truncation' strategy does not exist [...] Available strategies: truncation
  # As a temporary workaround, including mongoid-tree in your Gemfile solves it for now.
  gem 'mongoid-tree', :require => 'mongoid/tree'
  gem 'simplecov'
  gem 'factory_girl_rails'
  gem 'rspec-rails', '~> 3.2.1'
  gem 'rspec-support', '~> 3.2.2'
  gem 'capybara'
  gem 'launchy'
  gem 'shoulda-matchers'
  gem 'capybara-webkit'
  gem 'capybara-screenshot'
  gem 'database_cleaner'
  gem 'mongoid-rspec'
end

group :production do
  gem 'rails_12factor'
  gem 'newrelic_rpm'
  gem 'unicorn'
end

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
