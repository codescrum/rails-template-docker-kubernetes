require 'rails_helper'

feature 'Welcome Page' do
  scenario 'do the thing', :js do
    visit '/'
    # Just testing the Poltergeist benefits
    page.save_screenshot File.join(Rails.root, 'tmp', 'capybara', 'test.png')
    expect(page).to have_content 'Foo Application'
    element = find '.btn.btn-lg.btn-primary'
    element.native.trigger :click
    expect(page).to have_content 'Sign In'
  end

  scenario 'do the ping', :vcr do
    expect(make_http_request).to be_eql 'pong!'
  end
end

#
# Makes a simple HTTP request to Locahost (testing purpose)
#
def make_http_request
  Net::HTTP.get_response('localhost', '/ping', 3000).body
end
