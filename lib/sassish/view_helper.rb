# Add the necessary view helpers for Sassish
module Sassish
  module ViewHelper
    #
    # Modifies the stylesheet_link_tag invocation for adding both a dynamic css resource
    # and manual resources added for the add_css_reource helper
    #
    # @param [ String ] manifest, this is the reference for the stylesheet manifest
    # @param [ Hash ] options, common options for the stylesheet_link_tag helper
    #
    def sassish_stylesheet_link_tag(manifest, options = {})
      # Relative path to the stylesheet by a specfic controller
      dynamic_stylesheet_resource = "#{File.join(Sassish.relative_stylesheet_directory_path, "#{controller_name}")}"
      # For checking if the real stylesheet resource exists
      stylesheet_resource_full_path = File.join(Rails.root, Sassish.relative_root_for_stylesheets, "#{dynamic_stylesheet_resource}.#{Rails.configuration.sass.preferred_syntax}")
      # Checks if the the real stylesheet resource exists
      # Resources from added_sassish_stylesheets
      raw_added_style_resources = content_for(:added_sassish_stylesheets) || ''
      added_style_resources = raw_added_style_resources.split(',').map(&:strip)
      # Essential stylesheet files (please note that the order is important)
      added_style_resources.unshift dynamic_stylesheet_resource if sassish_stylesheet_resource_exists? stylesheet_resource_full_path
      added_style_resources.unshift manifest
      # Invokes the real stylesheet_link_tag
      stylesheet_link_tag *added_style_resources, options
    end


    #
    # Adds a css resource for loading it from the sassish_stylesheet_link_tag helper.
    # It uses content_for helper explicitly
    #
    # @param [ String ] resource_paths relative path to the css resources (use comma
    #                   for separating them), root path is set to app/assets/stylesheets
    #
    # @example
    #
    #   add_style_resource 'main/styles/my_stylesheet.css, vendor/stylesheets/cat.css'
    #
    def add_style_resource(resource_paths)
      content_for :added_sassish_stylesheets, resource_paths
    end

    private

    #
    # Checks if the specific stylesheet resource exists using the selected checking strategy
    # either hard disk verfication or caching approach. You can configure that using the config
    # variable in the enevironment you wish
    #
    #   config.sassish.cache_stylesheet_resources = false # disable caching strategy in favor of hard-disk approach
    #
    # @param [ String ] stylesheet_resource_full_path
    #
    def sassish_stylesheet_resource_exists?(stylesheet_resource_full_path)
      if Rails.configuration.sassish.cache_stylesheet_resources
        sassish_cache = Rails.cache.fetch("sassish")
        resource = assish_cache["stylesheet-#{controller_name}"]
        resource.nil? ? assish_cache["stylesheet-#{controller_name}"] = File.exist?(stylesheet_resource_full_path) : resource
      else
        File.exist? stylesheet_resource_full_path
      end
    end
  end
end

