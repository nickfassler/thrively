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
    fill_in 'Feedback subject', with: 'Test feedback subject'
    fill_in 'Did well', with: 'Something'
    fill_in 'Improve', with: 'Something'
    click_button 'Send'

    current_path.should == dashboard_path
    page.should have_content('Feedback was successful')
  end

  scenario 'User must fill in all fields to give feedback' do
    sign_in_as @giver
    click_link 'Give Feedback'
    fill_in 'Feedback subject', with: 'Test feedback subject'
    click_button 'Send'

    current_path.should == feedbacks_path
    page.should have_content('There is an error')
  end
end
