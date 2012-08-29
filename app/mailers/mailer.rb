class Mailer < ActionMailer::Base
  default from: 'noreply@thrive.ly'

  def request_sent(request, receiver)
    @request = request
    @receiver = receiver
    mail(
      from: "Full Name via Thrively <#{request.user.email}>",
      to: @receiver.email,
      subject: 'Please give me feedback with Thrively'
    )
  end

  def feedback_given(feedback)
    @feedback = feedback
    mail(
      from: "Full Name via Thrively <#{feedback.giver.email}>",
      to: feedback.receiver.email,
      subject: "Feedback on: #{feedback.subject}"
    )
  end
end
