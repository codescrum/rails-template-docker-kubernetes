require 'rails_helper'
require 'ammeter/init'
require 'rails/generators'
require 'rails/generators/rails/scaffold/scaffold_generator'

describe Rails::Generators::ScaffoldGenerator, type: :generator do
  # Tell the generator where to put its output (what it thinks of as Rails.root)
  DESTINATION = File.expand_path('../../../tmp/tests', __FILE__)
  destination DESTINATION

  context 'SASS Sysntax' do
    before do
      prepare_destination
      assets_initializer_content =  <<-eos
        # Be sure to restart your server when you modify this file.

        # Version of your assets, change this if you want to expire all your assets.
        Rails.application.config.assets.version = '1.0'

        # Precompile additional assets.
        # application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
        Rails.application.config.assets.precompile += %w( application-welcome.css application-session.css )
      eos
      dirname = File.join(DESTINATION, 'config', 'initializers')
      unless File.directory?(dirname)
        FileUtils.mkdir_p(dirname)
      end
      File.open(File.join(dirname, 'assets.rb'), 'w') {|f| f.write assets_initializer_content }
      # A random scaffolding for Chiguiro Model
      run_generator %w(chiguiro --skip-resource_route)
    end

    context 'initializer' do
      subject { file 'config/initializers/assets.rb' }
      it { should contain /%w\( main\/styles\/chiguiros.css/ }
    end

    context 'stylesheet folder' do
      subject { file 'app/assets/stylesheets/main/styles/chiguiros.sass' }
      it { should exist }
      it { should contain /Place all the styles related to the chiguiros controller here./ }
    end
  end

  context 'SCSS Sysntax' do
    before do
      Rails.configuration.sass.preferred_syntax = :scss
      prepare_destination
      assets_initializer_content =  <<-eos
        # Be sure to restart your server when you modify this file.

        # Version of your assets, change this if you want to expire all your assets.
        Rails.application.config.assets.version = '1.0'

        # Precompile additional assets.
        # application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
        Rails.application.config.assets.precompile += %w( application-welcome.css application-session.css )
      eos
      dirname = File.join(DESTINATION, 'config', 'initializers')
      unless File.directory?(dirname)
        FileUtils.mkdir_p(dirname)
      end
      File.open(File.join(dirname, 'assets.rb'), 'w') {|f| f.write assets_initializer_content }
      # A random scaffolding for Chiguiro Model
      run_generator %w(chiguiro --skip-resource_route --stylesheet-engine=scss)
    end

    context 'initializer' do
      subject { file 'config/initializers/assets.rb' }
      it { should contain /%w\( main\/styles\/chiguiros.css/ }
    end

    context 'stylesheet folder' do
      subject { file 'app/assets/stylesheets/main/styles/chiguiros.scss' }
      it { should exist }
      it { should contain /Place all the styles related to the chiguiros controller here./ }
    end
  end
end
