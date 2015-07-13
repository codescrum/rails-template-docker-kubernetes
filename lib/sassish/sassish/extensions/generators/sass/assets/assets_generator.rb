# An elegant way for monkey patching teh SASS generator
# TODO: refactor with the scss mokey patch logic
module Sassish
  module Extensions
    module Generators
      module Sass
        module Assets
          module AssetsGenerator
            def self.included(klass)
              klass.class_eval do
                # Defines the first step for overriding the :copy_sass method
                remove_method :copy_sass

                #
                # [HACK] This option is addded for solving the precompiled_stylesheet hook issue, see problem below, in the hook 
                # declaration
                #
                class_option :precompiled_stylesheet, desc: "invoke precompiled stylesheet", default: true

                #
                # it invokes the specified generator, but take into account that if the --precompiled_stylesheet flag is not set
                # you could not perform this process (neither invoke the customized &block), for that reason we make the 
                # precompiled_stylesheet class_option and we set this flag to default: true.
                #
                # The bad thing is that you can not do that (specify the --precompiled_stylesheet flag) using the config magic
                # through a rails engine or the application itself, because the hook itself will not be called at least the 
                # precompiled_stylesheet is set.
                #
                # Finally, you cannot pass the options to the hook directly neither:
                #
                #   hook_for :precompiled_stylesheet, in: :rails, as: :precompiled_stylesheet, precompiled_stylesheet: true
                #
                # At the end we should have that our class responds to the _invoke_from_option_precompiled_stylesheet instance method
                #
                hook_for :precompiled_stylesheet, in: :rails, as: :precompiled_stylesheet do |instance, klass|
                  instance.invoke klass, [instance.name]
                end
              end
            end

            #
            # re-declares the copy_sass method when this module is included
            #
            def copy_sass
              template "stylesheet.sass", File.join(Sassish.stylesheet_directory_path, class_path, "#{file_name}.sass")
            end
          end
        end
      end
    end
  end
end
