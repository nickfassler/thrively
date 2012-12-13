class Experience
  include Capybara::DSL
  include FactoryGirl::Syntax::Methods
  include Rails.application.routes.url_helpers

  def sign_out
    click_link 'Sign out'
  end

  def last_sent_email
    ActionMailer::Base.deliveries.last
  end

  def sent_emails
    ActionMailer::Base.deliveries
  end

  def sent_email_with_subject(regex)
    sent_emails.detect { |email| email.subject =~ regex }
  end

  def last_sent_email_body
    last_sent_email.parts.last.body
  end
end
