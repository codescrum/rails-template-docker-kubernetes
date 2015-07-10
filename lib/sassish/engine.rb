module Sassish
  class Engine < Rails::Railtie
    sassish_config = ActiveSupport::OrderedOptions.new
    sassish_config[:cache_stylesheet_resources] = false
    config.sassish = sassish_config

    initializer "sassish.view_helper" do
      ActionView::Base.__send__ :include, Sassish::ViewHelper
    end
  end
end
