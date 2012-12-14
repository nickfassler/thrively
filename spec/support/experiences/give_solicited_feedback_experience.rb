class GiveSolicitedFeedbackExperience < Experience
  def initialize(you)
    @you = you
    @friend = create(:user)
  end

  def request_feedback
    request = create(:request, user: @friend, emails: [@you.email])
    @requested_feedback = request.requested_feedbacks.first
  end

  def give_feedback
    click_link_in_request_email
    fill_in 'What works', with: 'Good attitude'
    fill_in 'What to improve', with: 'Need more smiles'
    click_button 'Give feedback'
  end

  def has_given_feedback?
    page.has_content?('Your feedback was sent successfully')
  end

  def has_delivered_feedback_to_friend?
    feedback_email.to.include?(@friend.email) &&
      feedback_email.reply_to.include?(@you.email)
  end

  def has_delivered_thank_you?
    thank_you_email.to.include?(@you.email)
  end

  def has_welcomed_you?
    page.has_content?('Get started with Thrively')
  end

  private

  def click_link_in_request_email
    if @you.is_a?(User)
      visit requested_feedback_path(@requested_feedback, as: @you)
    else
      visit requested_feedback_path(@requested_feedback)
    end
  end

  def feedback_email
    @feedback_email ||= sent_email_with_subject(/Feedback on/)
  end

  def thank_you_email
    @thank_you_email ||= sent_email_with_subject(
      /Thanks for giving feedback to #{@friend.name}/
    )
  end
end
