require 'spec_helper'

describe FeedbackCreatedJob do
  describe '.enqueue' do
    it 'enqueues the job' do
      feedback = build_stubbed(:feedback)

      FeedbackCreatedJob.enqueue(feedback)

      should enqueue_delayed_job('FeedbackCreatedJob').
        with_attributes(feedback_id: feedback.id).
        priority(1)
    end
  end

  describe '#perform' do
    it 'creates history events for feedback giver and receiver' do
      feedback = create(:feedback)

      FeedbackCreatedJob.new(feedback.id).perform

      HistoryEvent.all.map(&:owner).should == [feedback.giver, feedback.receiver]
    end

    it 'delivers feedback' do
      feedback = build_stubbed(:feedback)
      Feedback.stub(find: feedback)
      Mailer.stub_chain(:feedback_given, :deliver)

      FeedbackCreatedJob.new(feedback.id).perform

      Mailer.should have_received(:feedback_given).with(feedback)
    end

    it 'delivers thank to to guest feedback giver' do
      guest = build_stubbed(:guest)
      feedback = build_stubbed(:feedback, giver: guest)
      Feedback.stub(find: feedback)
      Mailer.stub_chain(:thank_you, :deliver)

      FeedbackCreatedJob.new(feedback.id).perform

      Mailer.should have_received(:thank_you).with(feedback)
    end
  end
end
