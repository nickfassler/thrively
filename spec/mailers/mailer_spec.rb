require 'spec_helper'

describe Mailer do
  describe 'request_sent' do
    it 'contructs the headers' do
      request = build(:request)
      receiver = request.requested_feedbacks.first.giver
      mail = Mailer.request_sent(request, receiver)

      mail.to.should == [receiver.email]
      mail.from.should == [request.user.email]
      mail.subject.should =~ /Please give me feedback/
    end

    it 'contructs the body' do
      request = build(:request)
      receiver = request.requested_feedbacks.first.giver
      mail = Mailer.request_sent(request, receiver)
      body = mail.parts.last.body

      body.should include(receiver.email)
      body.should include(request.user.email)
      body.should include(request.subject)
      body.should include(request.message)
      body.should include(new_feedback_url(request_id: request.id))
    end
  end

  describe 'feedback_given' do
    it 'contructs the headers' do
      feedback = build(:feedback)
      mail = Mailer.feedback_given(feedback)

      mail.to.should == [feedback.receiver.email]
      mail.from.should == [feedback.giver.email]
      mail.subject.should == "Feedback on: #{feedback.subject}"
    end

    it 'contructs the body' do
      feedback = build(:feedback)
      mail = Mailer.feedback_given(feedback)
      body = mail.parts.last.body

      body.should include(feedback.receiver.email)
      body.should include(feedback.giver.email)
      body.should include(feedback.subject)
      body.should include(feedback.plus)
      body.should include(feedback.delta)
    end
  end
end
