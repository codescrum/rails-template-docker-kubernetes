module Sassish
  module Extensions
    module Generators
      module Sass
        module Assets
          module AssetsGenerator
            # Defines the first step for overriding the :copy_sass method
            def self.included(klass)
              klass.class_eval do
                remove_method :copy_sass
              end
            end

            # override the :copy_sass method
            def copy_sass
              template "stylesheet.sass", File.join(Sassish.stylesheet_directory_path, class_path, "#{file_name}.sass")
            end
          end
        end
      end
    end
  end
end
