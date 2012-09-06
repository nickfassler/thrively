class Mailer < ActionMailer::Base
  THRIVELY_EMAIL_ADDRESS = 'app@thrive.ly'

  default reply_to: THRIVELY_EMAIL_ADDRESS

  def invite_created(invite)
    @invite = invite
    @user = invite.user
    mail(
      from: from_text(@user),
      reply_to: @user.email,
      to: invite.email,
      subject: "I'd like to invite you to Thrively"
    )
  end

  def request_sent(requested_feedback)
    @requested_feedback = requested_feedback
    mail(
      from: from_text(requested_feedback.requester),
      reply_to: requested_feedback.request.user.email,
      to: requested_feedback.giver.email,
      subject: 'Please give me feedback with Thrively'
    )
  end

  def feedback_given(feedback)
    @feedback = feedback
    mail(
      from: from_text(feedback.giver),
      reply_to: feedback.giver.email,
      to: feedback.receiver_email,
      subject: "Feedback on: #{feedback.topic}"
    )
  end

  private

  def from_text(sender)
    "#{sender.name} via Thrively <#{THRIVELY_EMAIL_ADDRESS}>"
  end
end
