class RequestFeedbackExperience < Experience
  def initialize(you)
    @you = you
    @friend = create(:user)
  end

  def request_feedback
    visit new_request_path(as: @you)
    find("input[name*='email']").set(@friend.email)
    fill_in 'Topic', with: 'Test request topic'
    fill_in 'Email Message', with: 'Hi friend. Please give me feedback.'
    click_button 'Send'
  end

  def try_to_request_feedback
    visit new_request_path
  end

  def impossible_to_request_feedback?
    current_path == sign_in_path
  end

  def has_requested_feedback?
    current_path == dashboard_path &&
      page.has_content?('Your feedback request was sent successfully')
  end

  def has_delivered_request_to_friend?
    request_email.to.include?(@friend.email)
  end

  private

  def request_email
    @request_email ||= sent_email_with_subject(/Please give me feedback/)
  end
end
