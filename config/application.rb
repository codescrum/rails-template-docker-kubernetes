require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require "active_model/railtie"
# require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RailsTemplate
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Auto-loading lib files
    config.autoload_paths << Rails.root.join('lib/sassish')

    # Avoids that each controller loads all existent helpers, this could be a problem
    # when you try to segment your helper methods
    config.action_controller.include_all_helpers = false
  end
end

# Require Sassish
require File.expand_path(File.join('..', '..', 'lib', 'sassish', 'sassish.rb'), __FILE__)

###### Heroku deployment hack ######
# copy mongoid config example file into 'real' file
# if Rails.env.production? || Rails.env.staging?
#   config_root = File.join(Rails.root, 'config')
#   # Mongoid Config File
#   mongoid_example_path = File.join(config_root, 'mongoid.yml.example')
#   mongoid_real_path = File.join(config_root, 'mongoid.yml')
#   `cp #{mongoid_example_path} #{mongoid_real_path}`
#   # Secrets File
#   secrets_example_path = File.join(config_root, 'secrets.yml.example')
#   secrets_real_path = File.join(config_root, 'secrets.yml')
#   `cp #{secrets_example_path} #{secrets_real_path}`
# end
