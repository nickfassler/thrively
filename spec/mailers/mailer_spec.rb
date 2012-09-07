require 'spec_helper'

describe Mailer do
  describe 'invite_created' do
    it 'contructs the headers' do
      invite = create(:invite)

      mail = Mailer.invite_created(invite)

      mail.to.should == [invite.email]
      mail.from.should == [Mailer::THRIVELY_EMAIL_ADDRESS]
      mail.reply_to.should == [invite.user.email]
      mail.subject.should =~ /invite you to Thrively/
    end

    it 'contructs the body' do
      invite = create(:invite)

      mail = Mailer.invite_created(invite)

      body = mail.parts.last.body
      body.should include(accept_url(invite: invite.token))
    end
  end

  describe 'request_sent' do
    it 'contructs the headers' do
      requested_feedback = build_stubbed(:requested_feedback)

      mail = Mailer.request_sent(requested_feedback)

      mail.to.should == [requested_feedback.giver_email]
      mail.from.should == [Mailer::THRIVELY_EMAIL_ADDRESS]
      mail.reply_to.should == [requested_feedback.requester_email]
      mail.subject.should =~ /Please give me feedback/
    end

    it 'contructs the body' do
      requested_feedback = build_stubbed(:requested_feedback)

      mail = Mailer.request_sent(requested_feedback)

      body = mail.parts.last.body
      body.should include(requested_feedback.giver_name)
      body.should include(requested_feedback.requester_name)
      body.should include(requested_feedback.request.topic)
      body.should include(requested_feedback.request.message)
      body.should include(requested_feedback_url(requested_feedback))
    end
  end

  describe 'feedback_given' do
    it 'contructs the headers' do
      feedback = build_stubbed(:feedback)

      mail = Mailer.feedback_given(feedback)

      mail.to.should == [feedback.receiver_email]
      mail.from.should == [Mailer::THRIVELY_EMAIL_ADDRESS]
      mail.reply_to.should == [feedback.giver_email]
      mail.subject.should == "Feedback on: #{feedback.topic}"
    end

    it 'contructs the body' do
      feedback = build_stubbed(:feedback)

      mail = Mailer.feedback_given(feedback)

      body = mail.parts.last.body
      body.should include(feedback.receiver_name)
      body.should include(feedback.giver_name)
      body.should include(feedback.topic)
      body.should include(feedback.plus)
      body.should include(feedback.delta)
    end
  end

  describe 'welcome' do
    it 'contructs the headers' do
      user = build_stubbed(:user)
      mail = Mailer.welcome(user)

      mail.to.should == [user.email]
      mail.from.should == ['support@thrive.ly']
      mail.subject.should == 'Welcome to Thrively!'
    end

    it 'constructs the body' do
      user = build_stubbed(:user)
      mail = Mailer.welcome(user)
      body = mail.parts.last.body

      body.should include(user.name)
      body.should include(new_request_url)
      body.should include('support@thrive.ly')
    end
  end

  describe 'thank_you' do
    it 'contructs the headers' do
      guest = build_stubbed(:guest)
      feedback = build_stubbed(:feedback)
      mail = Mailer.thank_you(guest, feedback.receiver)

      mail.to.should == [guest.email]
      mail.from.should == ['support@thrive.ly']
      mail.subject.
        should == "Thanks for giving feedback to #{feedback.receiver_name}"
    end

    it 'constructs the body' do
      guest = build_stubbed(:guest)
      feedback = build_stubbed(:feedback)
      mail = Mailer.thank_you(guest, feedback.receiver)
      body = mail.parts.last.body

      body.should include("feedback to #{feedback.receiver_name}")
      body.should include('support@thrive.ly')
    end
  end

  describe 'email_changed' do
    it 'contructs the headers' do
      user = build_stubbed(:user)
      mail = Mailer.email_changed(user)

      mail.to.should == [user.email]
      mail.from.should == ['support@thrive.ly']
      mail.subject.should == 'Your updated settings on Thrively'
    end

    it 'constructs the body' do
      user = create(:user)
      user.email = 'edited_email@example.com'
      mail = Mailer.email_changed(user)
      body = mail.parts.last.body

      body.should include(user.email_was)
      body.should include(user.email)
      body.should include(user.name)
      body.should include('just updated your email')
      body.should include('support@thrive.ly')
    end
  end
end
