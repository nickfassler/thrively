module MailerMacros
  def sent_emails
    ActionMailer::Base.deliveries
  end

  def sent_email_with_subject(regex)
    sent_emails.detect { |email| email.subject =~ regex }
  end

  def last_sent_email
    ActionMailer::Base.deliveries.last
  end

  def last_sent_email_body
    last_sent_email.parts.last.body
  end

  def reset_email
    ActionMailer::Base.deliveries = []
  end
end
