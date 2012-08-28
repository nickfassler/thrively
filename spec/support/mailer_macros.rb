module MailerMacros
  def sent_emails
    ActionMailer::Base.deliveries
  end

  def last_sent_email
    ActionMailer::Base.deliveries.last
  end

  def reset_email
    ActionMailer::Base.deliveries = []
  end
end
