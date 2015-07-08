require "sass/rails"
require "rails/generators"
require "rails/generators/sass/assets/assets_generator"
require "rails/generators/scss/assets/assets_generator"
require File.expand_path(File.join('..', 'extensions', 'generators', 'sass', 'assets', 'assets_generator'), __FILE__)
require File.expand_path(File.join('..', 'extensions', 'generators', 'scss', 'assets', 'assets_generator'), __FILE__)

# This module adapts almost all the generators associated with the stylesheet organization approach
# described on the Readme file.
module Sassish

  # relative root for the stylesheets, it will be used for configuring the
  # location for the sass template (rails generator)
  mattr_accessor :relative_root_for_stylesheets

  # Sets the new stylesheet location app/assets/stylesheets/<location>
  mattr_accessor :stylesheet_directory_path

  #
  # Defines a new stylesheet folder location and starts the monkey patching for the stylesheet generators
  #
  # @param [String] relative_stylesheet_path
  #
  def self.define_stylesheet_path(relative_stylesheet_path)
    self.relative_root_for_stylesheets = 'app/assets/stylesheets'
    self.stylesheet_directory_path = File.join(relative_root_for_stylesheets, relative_stylesheet_path)
    self.modify_stylesheet_generators
  end

  #
  # Apply monkey patching on stylesheet generators
  #
  def self.modify_stylesheet_generators
    Sass::Generators::AssetsGenerator.__send__ :include, Sassish::Extensions::Generators::Sass::Assets::AssetsGenerator
    Scss::Generators::AssetsGenerator.__send__ :include, Sassish::Extensions::Generators::Scss::Assets::AssetsGenerator
  end

  # defines wrapped accessor to Sassish configurator
  def self.setup
    yield self
  end
end
