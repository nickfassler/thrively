require 'spec_helper'

feature 'Requests' do
  background do
    @requester = create(:user, email: 'user@example.com')
    @giver = create(:user, email: 'guest@example.com')
  end

  scenario 'User can create a feedback request' do
    sign_in_as @requester.email
    click_link 'Request feedback'
    fill_in_email(@giver.email)
    fill_in 'Subject', with: 'Test request subject'
    fill_in 'Email Message', with: 'Hi friend. Please give me feedback.'
    click_button 'Send'

    current_path.should == dashboard_path
    page.should have_content('Feedback request sent successfully')
  end

  scenario 'User can create feedback request with multiple emails', js: true  do
    @giver2 = create(:user, email: 'guest2@example.com')

    sign_in_as @requester.email
    click_link 'Request feedback'
    fill_in_email(@giver.email)
    click_link 'add'
    fill_in_email(@giver2.email)
    click_button 'Send'

    current_path.should == dashboard_path
    page.should have_content('Feedback request sent successfully')
  end

  scenario 'User cannot submit feedback request without valid email' do
    sign_in_as @requester.email
    click_link 'Request feedback'
    fill_in_email('guest@example')
    click_button 'Send'

    current_path.should == requests_path
    page.should have_content('error prevented')
  end

  scenario 'Guest cannot access feeback request page' do
    visit new_request_path

    current_path.should == sign_in_path
    page.should have_content('Sign in')
  end

  def fill_in_email(email)
    all('form input.email').last.set(email)
  end

  def sign_in_as(email)
    visit root_path
    fill_in 'Email', with: email
    fill_in 'Password', with: 'password'
    click_button 'Sign in'
  end
end
