require 'spec_helper'

describe HistoryEventDecorator do
  describe '#html_classes' do
    it 'contains classes for feedback sender' do
      feedback = create(:feedback)
      decorator_for(feedback, feedback.giver).html_classes.should include('feedback', 'sent')
    end

    it 'contains classes for feedback receiver' do
      feedback = create(:feedback)
      decorator_for(feedback, feedback.receiver).html_classes.should include('feedback', 'received')
    end

    it 'contains classes for request sender' do
      request = create(:request)
      decorator_for(request, request.user).html_classes.should include('request', 'sent')
    end

    it 'contains classes for request receiver' do
      request = create(:request)
      decorator_for(request, request.requested_feedbacks.first.giver).
        html_classes.should include('request', 'received')
    end
  end

  describe '#header' do
    context 'for request' do
      it "contains requester's email in invitee's stream" do
        request = create(:request)
        invitee = request.requested_feedbacks.first.giver
        decorator_for(request, invitee).header.should =~ /#{request.user.email}/
      end

      it "contains invitee's email in requester's stream" do
        request = create(:request)
        invitee = request.requested_feedbacks.first.giver
        decorator_for(request, request.user).header.should =~ /#{invitee.email}/
      end
    end

    context 'for feedback' do
      it "contains receiver's email in giver's stream" do
        feedback = create(:feedback)
        decorator_for(feedback, feedback.giver).header.should =~ /#{feedback.receiver.email}/
      end

      it "contains giver's email for receiver's stream" do
        feedback = create(:feedback)
        decorator_for(feedback, feedback.receiver).header.should =~ /#{feedback.giver.email}/
      end
    end
  end

  describe '#body' do
    context 'for request' do
      it 'contains topic' do
        request = create(:request)
        decorator_for(request, request.user).body.should =~ /#{request.topic}/
      end

      it 'contains message' do
        request = create(:request)
        decorator_for(request, request.user).body.should =~ /#{request.message}/
      end
    end

    context 'for feedback' do
      it 'contains topic' do
        feedback = create(:feedback)
        decorator_for(feedback, feedback.receiver).body.should =~ /#{feedback.topic}/
      end

      it 'contains plus' do
        feedback = create(:feedback)
        decorator_for(feedback, feedback.receiver).body.should =~ /#{feedback.plus}/
      end

      it 'contains delta' do
        feedback = create(:feedback)
        decorator_for(feedback, feedback.receiver).body.should =~ /#{feedback.delta}/
      end
    end
  end

  private

  def decorator_for(resource, user)
    event = HistoryEvent.new(resource: resource, user_id: user.id)
    HistoryEventDecorator.new(event)
  end
end
