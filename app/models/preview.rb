if Rails.env.development?
  class Preview < MailView
    def invite_created
      invite = Invite.last
      Mailer.invite_created(invite)
    end

    def request_sent
      requested_feedback = RequestedFeedback.last
      Mailer.request_sent(requested_feedback)
    end

    def feedback_given
      feedback = Feedback.last
      Mailer.feedback_given(feedback)
    end

    def welcome
      user = User.last
      Mailer.welcome(user)
    end

    def thank_you
      guest = Guest.last
      feedback = Feedback.last
      Mailer.thank_you(guest, feedback.receiver)
    end

    def email_changed
      user = User.last
      Mailer.email_changed(user)
    end
  end
end
