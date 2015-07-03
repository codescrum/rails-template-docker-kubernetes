require 'rails_helper'

feature 'Welcome Page' do
  scenario 'Do the thing', js: true do
    visit '/'
    # Just testing the Poltergeist benefits
    page.save_screenshot File.join(Rails.root, 'tmp', 'capybara', 'test.png')
    expect(page).to have_content 'Foo Application'
    element = find '.btn.btn-lg.btn-primary'
    element.native.trigger :click
    expect(page).to have_content 'Sign In'
  end
end
