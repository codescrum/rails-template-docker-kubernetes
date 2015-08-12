source 'https://rubygems.org'

ruby '2.2.2'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.3'
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
gem 'secure_headers'
gem 'autoprefixer-rails'
gem 'sidekiq', '~> 3.1.4'


group :development do
  gem 'guard'
  gem 'haml-rails' # only in dev, because haml-rails adds the generators
  gem 'quiet_assets'
  gem 'rails_layout'
  gem 'bullet'
  gem 'meta_request'
  gem 'shog'
  # For supporting flamegraph without errors
  # see here: https://github.com/SamSaffron/flamegraph/blob/master/lib/flamegraph.rb#L5
  gem 'stackprof'
  gem 'rack-mini-profiler', require: false
  gem 'flamegraph'
  # gems for inspecting code qualitty
  gem 'i18n-tasks', '~> 0.7.12'
  gem 'rails_best_practices', require: false
  gem 'inch', require: false
  gem 'guard-inch'
  gem 'rubocop', require: false
  gem 'guard-rubocop'
  gem 'rubycritic', require: false
  gem 'guard-rubycritic'
  gem 'brakeman-min', require: false
end

group :development, :test do
  gem 'jazz_hands', github: 'jkrmr/jazz_hands'
  # If you use gems that require environment variables to be set before they are loaded,
  # then list dotenv-rails in the Gemfile before those other gems and require dotenv/rails-now.
  # gem 'dotenv-rails', :require => 'dotenv/rails-now'
  # gem 'gem-that-requires-env-variables'
  gem 'dotenv-rails'
end

group :test do
  # [ERROR] The 'truncation' strategy does not exist [...] Available strategies: truncation
  # As a temporary workaround, including mongoid-tree in your Gemfile solves it for now.
  gem 'mongoid-tree', :require => 'mongoid/tree'
  gem 'simplecov'
  gem 'simplecov-html'
  gem 'vcr'
  gem 'webmock'
  gem 'faker'
  gem 'factory_girl_rails'
  gem 'rspec-rails', '~> 3.2.1'
  gem 'rspec-support', '~> 3.2.2'
  gem 'capybara'
  gem 'launchy'
  gem 'shoulda-matchers'
  gem 'poltergeist'
  gem 'capybara-screenshot'
  gem 'database_cleaner'
  gem 'mongoid-rspec'
  gem 'ammeter'
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
