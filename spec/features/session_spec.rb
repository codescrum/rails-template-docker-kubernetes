require 'rails_helper'

feature 'Session' do
  before do
    create :user
  end

  scenario 'logs into new session' do
    visit '/users/sign_in'
    within '#new_user' do
      fill_in 'user[email]', with: User.first.email
      fill_in 'user[password]', with: '123456789'
    end
    click_button 'Sign In'
    expect(page).to have_content 'Foo Application'
  end
end
