require 'spec_helper'

describe Sassish, type: :generator do
  it 'verifies if was monkeypatched' do
    expect(Sass::Generators::AssetsGenerator.instance_methods).to include :copy_sass
    expect(Sass::Generators::AssetsGenerator.instance_methods).to include :_invoke_from_option_precompiled_stylesheet
  end
end
