require 'spec_helper'

feature 'Feedbacks' do
  background do
    @receiver = create(:user)
    @giver = create(:user)
  end

  scenario 'User can give feedback to another user' do
    sign_in_as @giver
    click_link 'Give Feedback'
    fill_in 'Email', with: @receiver.email
    fill_in 'Topic', with: 'Test feedback topic'
    fill_in 'Did well', with: 'Something'
    fill_in 'Improve', with: 'Something'
    click_button 'Send'

    current_path.should == dashboard_path
    page.should have_content('Feedback was successful')
    last_sent_email.to.should include(@receiver.email)
  end

  scenario 'User must fill in all fields to give feedback' do
    sign_in_as @giver
    click_link 'Give Feedback'
    fill_in 'Topic', with: 'Test feedback topic'
    click_button 'Send'

    current_path.should == feedbacks_path
    page.should have_content('There is an error')
    last_sent_email.should be_nil
  end

  scenario 'User leaves feedback for a specific request' do
    request = create(:request,
      user: @receiver,
      requested_feedbacks:
        [build(:requested_feedback, giver: @giver, request: request)]
    )

    sign_in_as @giver
    click_link request.topic
    fill_in 'Did well', with: 'Good attitude'
    fill_in 'Improve', with: 'Need more smiles'
    click_button 'Send'

    current_path.should == dashboard_path
    last_sent_email.to.should include(@receiver.email)

    within('.app-box-content') do
      page.should have_content('Feedback was successful')
      page.should have_content('Good attitude')
    end
  end
end
