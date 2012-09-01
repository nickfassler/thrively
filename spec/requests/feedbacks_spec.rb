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
    click_link @receiver.email
    fill_in 'Topic', with: 'Daily standup'
    fill_in 'Did well', with: 'Good attitude'
    fill_in 'Improve', with: 'Need more smiles'
    click_button 'Send'

    current_path.should == root_path
    last_sent_email.to.should include(@receiver.email)
    page.should have_content('Feedback was successful')

    within('.feedback') do
      page.should have_content('Daily standup')
    end
  end

  scenario 'User leaves feedback for a specific request' do
    request = request_for(from: @receiver, to: @giver)

    sign_in_as @giver
    click_link request.topic
    fill_in 'Did well', with: 'Good attitude'
    fill_in 'Improve', with: 'Need more smiles'
    click_button 'Send'

    current_path.should == root_path
    last_sent_email.to.should include(@receiver.email)
    page.should have_content('Feedback was successful')

    within('.feedback') do
      page.should have_content(request.topic)
      page.should have_content('Good attitude')
    end
  end

  scenario 'Guest leaves feedback for a specific request' do
    guest = create(:guest)
    request = request_for(to: guest, from: @receiver)

    visit requested_feedback_path(request.requested_feedbacks.first)
    fill_in 'Did well', with: 'Good attitude'
    fill_in 'Improve', with: 'Need more smiles'
    click_button 'Send'

    current_path.should == root_path
    page.should have_content('Feedback was successful')
    last_sent_email.to.should include(@receiver.email)
    last_sent_email.from.should include(guest.email)
  end

  scenario 'Guest cannot leave feedback if he has not been requested' do
    request = create(:request, user: @receiver, emails: { '0' => 'guest@example.com' })

    visit requested_feedback_path(request.requested_feedbacks.first)
    fill_in 'Did well', with: 'Good attitude'
    fill_in 'Improve', with: 'Need more smiles'
    click_button 'Send'

    current_path.should == root_path
    last_sent_email.to.should include(@receiver.email)
    page.should have_content('Feedback was successful')
  end

  private

  def profile_page_for(user)
    profile_path(user_id: user.id)
  end

  def request_for(options = {})
    create(
      :request,
      user: options[:from],
      requested_feedbacks:
        [build(:requested_feedback, giver: options[:to], request: request)]
    )
  end
end
