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
    it 'calls request decorator when resource is a request' do
      request = create(:request)
      fake_request_decorator = double(header: double(html_safe: true))
      RequestDecorator.stub(:new).and_return(fake_request_decorator)

      decorator_for(request, request.user).header
      fake_request_decorator.should have_received(:header).with(request.user)
    end

    it 'calls feedback decorator when resource is a feedback' do
      feedback = create(:feedback)
      fake_feedback_decorator = double(header: double(html_safe: true))
      FeedbackDecorator.stub(:new).and_return(fake_feedback_decorator)

      decorator_for(feedback, feedback.giver).header
      fake_feedback_decorator.should have_received(:header).with(feedback.giver)
    end
  end

  describe '#body' do
    context 'for request' do
      it 'contains link to topic' do
        request = create(:request)
        decorator = decorator_for(request, request.requested_feedbacks.first.giver)
        decorator.body.should =~ regex_for_link(request.topic)
      end

      it 'contains non-link topic when sender is the current user' do
        request = create(:request)
        decorator_for(request, request.user).body.should_not =~ regex_for_link(request.topic)
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
    event = HistoryEvent.new(resource: resource, owner: user)
    HistoryEventDecorator.new(event)
  end
end
