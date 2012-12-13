class GiveUnsolicitedFeedbackExperience < Experience
  def initialize(you)
    @you = you
    @friend_email = 'friend@example.com'
  end

  def possible?
    visit root_path(as: @you)
    page.has_link?('Give Feedback')
  end

  def give_feedback
    visit new_feedback_path(as: @you)
    fill_in 'Email', with: @friend_email
    fill_in 'Topic', with: 'Test feedback topic'
    fill_in 'What works', with: 'Something'
    fill_in 'What to improve', with: 'Something'
    click_button 'Give feedback'
  end

  def has_given_feedback?
    current_path == root_path &&
      page.has_content?('Your feedback was sent successfully') &&
      last_sent_email.to.include?(@friend_email)
  end
end
