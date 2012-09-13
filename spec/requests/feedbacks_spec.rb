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

    current_path.should == root_path
    page.should have_content('Feedback was successful')
    last_sent_email.to.should include(@receiver.email)
  end

  scenario 'User must fill in all fields to give feedback' do
    reset_email

    sign_in_as @giver
    click_link 'Give Feedback'
    fill_in 'Topic', with: 'Test feedback topic'
    click_button 'Send'

    current_path.should == feedbacks_path
    page.should have_content('There is an error')
    last_sent_email.should be_nil
  end

  scenario 'User leaves feedback for another user' do
    request_for(from: @receiver, to: @giver)

    sign_in_as @giver
    click_link @receiver.name
    fill_in 'Topic', with: 'Daily standup'
    fill_in 'Did well', with: 'Good attitude'
    fill_in 'Improve', with: 'Need more smiles'
    click_button 'Send'

    current_path.should == root_path
    last_sent_email.to.should include(@receiver.email)
    page.should have_content('Feedback was successful')

    within('.feedback') do
      page.should have_content("You gave feedback to #{@receiver.name}")
    end
  end

  scenario 'User leaves feedback for a specific request' do
    reset_email
    request = request_for(from: @receiver, to: @giver)

    sign_in_as @giver
    click_link request.topic
    fill_in 'Did well', with: 'Good attitude'
    fill_in 'Improve', with: 'Need more smiles'
    click_button 'Send'

    current_path.should == root_path
    page.should have_content('Feedback was successful')

    within('.feedback') do
      page.should have_content("You gave feedback to #{@receiver.name}")
    end

    last_sent_email.to.should include(@receiver.email)
  end

  scenario 'Guest leaves feedback for a specific request' do
    reset_email
    guest = create(:guest)
    request = request_for(to: guest, from: @receiver)
    requested_feedback = request.requested_feedbacks.first

    visit requested_feedback_path(requested_feedback)
    fill_in 'Did well', with: 'Good attitude'
    fill_in 'Improve', with: 'Need more smiles'
    click_button 'Send'

    current_path.should == root_path
    page.should have_content('Feedback was successful')

    feedback_received_email = sent_email_with_subject(/Feedback on/)
    thank_you_email = last_sent_email

    feedback_received_email.to.should include(@receiver.email)
    feedback_received_email.reply_to.should include(guest.email)
    thank_you_email.to.should include(guest.email)
  end

  scenario 'Guest cannot leave feedback if he has not been requested' do
    request = create(:request)

    visit requested_feedback_path(request.requested_feedbacks.first)

    current_path.should == sign_in_path
    page.should_not have_content('Give Feedback')
  end

  private

  def request_for(options = {})
    create(
      :request,
      user: options[:from],
      requested_feedbacks:
        [build(:requested_feedback, giver: options[:to], request: request)]
    )
  end
end
