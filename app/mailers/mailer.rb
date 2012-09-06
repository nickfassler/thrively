class Mailer < ActionMailer::Base
  default from: 'noreply@thrive.ly'

  def request_sent(requested_feedback)
    @requested_feedback = requested_feedback
    mail(
      from: from_text(requested_feedback.requester),
      to: requested_feedback.giver_email,
      subject: 'Please give me feedback with Thrively'
    )
  end

  def feedback_given(feedback)
    @feedback = feedback
    mail(
      from: from_text(feedback.giver),
      to: feedback.receiver_email,
      subject: "Feedback on: #{feedback.topic}"
    )
  end

  private

  def from_text(sender)
    "#{sender.name} via Thrively <#{sender.email}>"
  end
end
