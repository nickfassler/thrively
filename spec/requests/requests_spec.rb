require 'spec_helper'

feature 'Requests' do
  background do
    @requester = create(:user, email: 'user@example.com')
    @giver = create(:user, email: 'guest@example.com')
  end

  scenario 'User can create a feedback request' do
    sign_in_as @requester
    click_link 'Request Feedback'
    fill_in_email(@giver.email)
    fill_in 'Topic', with: 'Test request topic'
    fill_in 'Email Message', with: 'Hi friend. Please give me feedback.'
    click_button 'Send'

    current_path.should == dashboard_path
    page.should have_content('Feedback request sent successfully')
    last_sent_email.to.should include(@giver.email)
  end

  # scenario 'User can create feedback request with multiple emails', js: true  do
  #   giver2 = create(:user, email: 'guest2@example.com')
  #   reset_email

  #   sign_in_as @requester
  #   click_link 'Request Feedback'
  #   select "#{@giver.email},#{giver2.email}", from: 'request[emails][]'

  #   current_path.should == dashboard_path
  #   page.should have_content('Feedback request sent successfully')
  #   sent_emails.should have(2).items
  # end

  scenario 'User cannot submit feedback request without email' do
    reset_email

    sign_in_as @requester
    click_link 'Request Feedback'
    click_button 'Send'

    current_path.should == requests_path
    last_sent_email.should be_nil
  end

  scenario 'User cannot submit feedback with invalid email' do
    reset_email

    sign_in_as @requester
    click_link 'Request Feedback'
    fill_in_email('bad@email')
    click_button 'Send'

    current_path.should == requests_path
    last_sent_email.should be_nil
  end

  scenario 'Guest cannot access feeback request page' do
    visit new_request_path

    current_path.should == sign_in_path
    page.should have_content('Sign in')
  end
end
