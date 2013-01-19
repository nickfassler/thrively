class Mailer < ActionMailer::Base
  JOBS_ADDRESS = 'jobs@thrive.ly'
  SUPPORT_ADDRESS = 'support@thrive.ly'
  SUPPORT_FROM_FIELD = "Thrively <#{SUPPORT_ADDRESS}>"

  def invite_created(invite)
    @invite = invite
    @user = invite.user
    if @user.email == 'support@thrive.ly'
      mail(  
        from: SUPPORT_FROM_FIELD,
        to: invite.email,
        subject: "You've been invited to the Thrively beta"
        # subject: "Reminder: Your invite to the Thrively beta"
      )
    else
      mail(
        from: from_text(@user),
        reply_to: @user.email,
        to: invite.email,
        subject: "I'd like to invite you to Thrively"
      )
    end
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

  def welcome(user)
    @user = user

    mail(
      to: user.email,
      from: SUPPORT_FROM_FIELD,
      subject: 'Welcome to Thrively!'
    )
  end

  def thank_you(feedback)
    @guest = feedback.giver
    @feedback_receiver = feedback.receiver

    mail(
      to: @guest.email,
      from: SUPPORT_FROM_FIELD,
      subject: "Thanks for giving feedback to #{@feedback_receiver.name}"
    )
  end

  def email_changed(user)
    @user = user

    mail(
      to: user.email,
      from: SUPPORT_FROM_FIELD,
      subject: 'Your updated settings on Thrively'
    )
  end

  private

  def from_text(sender)
    "#{sender.name} via Thrively <#{SUPPORT_ADDRESS}>"
  end
end
