require 'rails_helper'

describe ApplicationHelper do
  it '#sassish_stylesheet_link_tag' do
    expect(helper.sassish_stylesheet_link_tag 'application', media: 'all', 'data-turbolinks-track' => true).to eql("<link rel=\"stylesheet\" media=\"all\" href=\"/assets/application.css\" data-turbolinks-track=\"true\" />")
  end

  it '#add_sassish_style' do
    helper.add_sassish_style 'main/style/my_style.css'
    expect(helper.sassish_stylesheet_link_tag 'application').to eql("<link rel=\"stylesheet\" media=\"screen\" href=\"/assets/application.css\" />\n<link rel=\"stylesheet\" media=\"screen\" href=\"/stylesheets/main/style/my_style.css\" />")
  end

  context 'Sassish will cache stylesheet resources' do
    before do
      Rails.configuration.sassish.cache_stylesheet_resources = true
    end

    it '#sassish_stylesheet_link_tag' do
      expect(helper.sassish_stylesheet_link_tag 'application', media: 'all', 'data-turbolinks-track' => true).to eql("<link rel=\"stylesheet\" media=\"all\" href=\"/assets/application.css\" data-turbolinks-track=\"true\" />")
    end

    it '#add_sassish_style' do
      helper.add_sassish_style 'main/style/my_style.css'
      expect(helper.sassish_stylesheet_link_tag 'application').to eql("<link rel=\"stylesheet\" media=\"screen\" href=\"/assets/application.css\" />\n<link rel=\"stylesheet\" media=\"screen\" href=\"/stylesheets/main/style/my_style.css\" />")
    end
  end
end
