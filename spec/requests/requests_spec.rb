require 'spec_helper'

feature 'Requests' do
  background do
    @requester = create(:user, email: 'user@example.com')
    @giver = create(:user, email: 'guest@example.com')
  end

  scenario 'User can create a feedback request from welcome page' do
    visit root_path(as: @requester)

    viewing_welcome?
    click_link 'Request feedback now'
    fill_in_email(@giver.email)
    fill_in 'Topic', with: 'Test request topic'
    fill_in 'Email Message', with: 'Hi friend. Please give me feedback.'
    click_button 'Send'

    current_path.should == dashboard_path
    page.should have_content('Your feedback request was sent successfully')
    last_sent_email.to.should include(@giver.email)
  end

  scenario 'User can create a feedback request from dashboard' do
    create_request = create(:request, user: @requester, emails: [@giver.email])
    visit root_path(as: @requester)

    viewing_dashboard?
    click_link 'Request Feedback'
    fill_in_email(@giver.email)
    fill_in 'Topic', with: 'Test request topic'
    fill_in 'Email Message', with: 'Hi friend. Please give me feedback.'
    click_button 'Send'

    current_path.should == dashboard_path
    page.should have_content('Your feedback request was sent successfully')
    last_sent_email.to.should include(@giver.email)
  end

  scenario 'User cannot submit feedback request without email' do
    create_request = create(:request, user: @requester, emails: [@giver.email])
    reset_email

    visit root_path(as: @requester)
    click_link 'Request Feedback'
    click_button 'Send'

    current_path.should == requests_path
    last_sent_email.should be_nil
  end

  scenario 'User cannot submit feedback with invalid email' do
    create_request = create(:request, user: @requester, emails: [@giver.email])
    reset_email

    visit root_path(as: @requester)
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

  def viewing_dashboard?
    page.should have_content('Stream')
  end

  def viewing_welcome?
    page.should have_content('Get started with Thrively')
  end
end
