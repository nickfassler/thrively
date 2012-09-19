require 'spec_helper'

describe RequestCreatedJob do
  describe '.enqueue' do
    it 'enqueues the job' do
      request = build_stubbed(:request)

      RequestCreatedJob.enqueue(request)

      should enqueue_delayed_job('RequestCreatedJob').
        with_attributes(request_id: request.id).
        priority(1)
    end
  end

  describe '#perform' do
    it 'delivers requested feedbacks' do
      request = create(:request)
      requested_feedback_one = create(:requested_feedback, request: request)
      requested_feedback_two = create(:requested_feedback, request: request)
      Mailer.stub_chain(:request_sent, :deliver)

      RequestCreatedJob.new(request.id).perform

      Mailer.should have_received(:request_sent).with(requested_feedback_one)
      Mailer.should have_received(:request_sent).with(requested_feedback_two)
    end

    it 'creates history event for request giver' do
      request = create(:request)

      RequestCreatedJob.new(request.id).perform

      history_event = HistoryEvent.first
      history_event.resource.should == request
      history_event.owner.should == request.giver
    end

    it 'creates history events for request invitees' do
      request = create(:request)

      RequestCreatedJob.new(request.id).perform

      history_event = HistoryEvent.last
      history_event.resource.should == request
      history_event.owner.should == request.invitees.first
    end
  end
end
