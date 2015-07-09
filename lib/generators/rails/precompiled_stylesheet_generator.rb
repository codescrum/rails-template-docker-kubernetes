module Rails
  module Generators
    class PrecompiledStylesheetGenerator < NamedBase
      argument :name, :type => :string, :required => true, :banner => 'Resource name'

      def add_stylesheet_to_precompilation_assets
        # YAY!
        binding.pry
        puts ''
      end
    end
  end
end
