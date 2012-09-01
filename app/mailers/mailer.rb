class Mailer < ActionMailer::Base
  default from: 'noreply@thrive.ly'

  def request_sent(requested_feedback)
    @requested_feedback = requested_feedback
    mail(
      from: "Full Name via Thrively <#{requested_feedback.request.user.email}>",
      to: requested_feedback.giver.email,
      subject: 'Please give me feedback with Thrively'
    )
  end

  def feedback_given(feedback)
    @feedback = feedback
    mail(
      from: "Full Name via Thrively <#{feedback.giver.email}>",
      to: feedback.receiver.email,
      subject: "Feedback on: #{feedback.topic}"
    )
  end
end
