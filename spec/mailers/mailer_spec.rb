require 'spec_helper'

describe Mailer do
  describe 'request_sent' do
    it 'contructs the headers' do
      requested_feedback = create(:requested_feedback)
      mail = Mailer.request_sent(requested_feedback)

      mail.to.should == [requested_feedback.giver_email]
      mail.from.should == [requested_feedback.requester_email]
      mail.subject.should =~ /Please give me feedback/
    end

    it 'contructs the body' do
      requested_feedback = create(:requested_feedback)
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
      feedback = build(:feedback)
      mail = Mailer.feedback_given(feedback)

      mail.to.should == [feedback.receiver_email]
      mail.from.should == [feedback.giver_email]
      mail.subject.should == "Feedback on: #{feedback.topic}"
    end

    it 'contructs the body' do
      feedback = build(:feedback)
      mail = Mailer.feedback_given(feedback)
      body = mail.parts.last.body

      body.should include(feedback.receiver_name)
      body.should include(feedback.giver_name)
      body.should include(feedback.topic)
      body.should include(feedback.plus)
      body.should include(feedback.delta)
    end
  end
end
