require 'spec_helper'

feature 'Authenticaton' do
  scenario 'User must fill in all fields on sign up form' do
    navigate_to_sign_up
    fill_in 'Name', with: 'Test User'
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign up'

    page.should have_content("Username can't be blank")

    fill_in 'Name', with: ''
    fill_in 'Username', with: 'test_user'
    click_button 'Sign up'

    page.should have_content("Name can't be blank")
  end

  scenario 'User signs up for an account and is taken to their dashboard' do
    navigate_to_sign_up
    fill_in 'Name', with: 'Test User'
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Username', with: 'test_user'
    click_button 'Sign up'

    page.should have_content('Stream')
  end

  scenario 'Existing user signs in and is taken to their dashboard' do
    user = create(:user, email: 'user@example.com')

    visit root_url
    click_link 'Sign in'
    fill_in 'Email', with: 'user@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign in'

    page.should have_content('Stream')
  end

  scenario 'Guest that has feedbacks signs up for an account' do
    guest = create(:guest)
    feedback1 = create(:feedback, giver: guest, topic: 'Meeting')
    feedback2 = create(:feedback, receiver: guest, topic: 'Intreview')

    navigate_to_sign_up
    fill_in 'Name', with: 'Converted Guest'
    fill_in 'Email', with: guest.email
    fill_in 'Password', with: 'password'
    fill_in 'Username', with: 'converted_guest'
    click_button 'Sign up'

    within('.app-box-content') do
      page.should have_content(feedback1.topic)
      page.should have_content(feedback2.topic)
    end
  end

  private

  def navigate_to_sign_up
    visit root_url
    click_link 'Sign in'
    click_link 'Sign up'
  end
end
