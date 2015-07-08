module Sassish
  module Extensions
    module Generators
      module Scss
        module Assets
          module AssetsGenerator
            # Defines the first step for overriding the :copy_scss method
            def self.included(klass)
              klass.class_eval do
                remove_method :copy_scss
              end
            end

            # override the :copy_scss method
            def copy_scss
              template 'stylesheet.scss', File.join(Sassish.stylesheet_directory_path, class_path, "#{file_name}.scss")
            end
          end
        end
      end
    end
  end
end
