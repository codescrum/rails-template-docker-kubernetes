require 'spec_helper'

# Sassish is included and configured by default, the reason for that is that Sassish is coupled with the
# Rails engine and we need to declare a specific configuration on Rails for defining how the sassish
# styles will be look for

# TODO: Sassish should be a gem, this is the reason for that the testing process is weird

describe Sassish do
  it 'verifies if Sassish is defined' do
    expect(defined?(Sassish)).to_not be_nil
  end

  it 'verfies that relative_root_for_stylesheets is well configured' do
    expected_response = 'app/assets/stylesheets'
    relative_root_for_stylesheets = Sassish.relative_root_for_stylesheets
    expect(relative_root_for_stylesheets).to eql expected_response
  end

  it 'verfies that stylesheet_directory_path is well configured' do
    expected_response = 'app/assets/stylesheets/main/styles'
    stylesheet_directory_path = Sassish.stylesheet_directory_path
    expect(stylesheet_directory_path).to eql expected_response
  end

  it 'verfies that relative_stylesheet_directory_path is well configured' do
    expected_response = 'main/styles'
    relative_stylesheet_directory_path = Sassish.relative_stylesheet_directory_path
    expect(relative_stylesheet_directory_path).to eql expected_response
  end

  it 'checks if Sassish Rails.cache key is cleared and redefined' do
    expect(Rails.cache.fetch('sassish')).to be_eql({})
  end
end
