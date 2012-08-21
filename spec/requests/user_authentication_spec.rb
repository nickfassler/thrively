require 'spec_helper'

feature 'UserAuthenticaton' do
  scenario 'Guest signs up for an account and is taken to their dashboard' do
    visit root_url
    click_link 'Sign in'
    click_link 'Sign up'
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign up'

    page.should have_content('Dashboard')
  end

  scenario 'Existing user signs in and is taken to their dashboard' do
    user = create(:user, email: 'user@example.com')

    visit root_url
    click_link 'Sign in'
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign in'

    page.should have_content('Dashboard')
  end
end
