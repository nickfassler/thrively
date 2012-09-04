require 'spec_helper'

describe FeedbackDecorator do
  describe '#header' do
    it "contains link to receiver's profile when receiver is a user" do
      feedback = build(:feedback)
      decorator = FeedbackDecorator.new(feedback)
      decorator.header(feedback.giver).should =~ regex_for_link(feedback.receiver_email)
    end

    it "does not contain link to receiver's profile when receiver is a user" do
      feedback = build(:feedback, receiver: create(:guest))
      decorator = FeedbackDecorator.new(feedback)
      decorator.header(feedback.giver).should_not =~ regex_for_link(feedback.receiver_email)
    end

    it "contains link to giver's profile when receiver is a user" do
      feedback = build(:feedback)
      decorator = FeedbackDecorator.new(feedback)
      decorator.header(feedback.receiver).should =~ regex_for_link(feedback.giver.email)
    end
  end
end
