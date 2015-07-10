module Rails
  module Generators
    class PrecompiledStylesheetGenerator < NamedBase
      argument :name, :type => :string, :required => true, :banner => 'Resource name'

      def add_stylesheet_to_precompilation_assets
        inside 'config' do
          inside 'initializers' do
            insert_into_file 'assets.rb', " #{File.join(Sassish.relative_stylesheet_directory_path, "#{name}.css")} ", after: "Rails.application.config.assets.precompile += %w("
          end  
        end
      end
    end
  end
end
