require 'spec_helper'

describe FeedbackObserver do
  describe '#after_create' do
    it 'enqueues a FeedbackCreatedJob' do
      feedback = build_stubbed(:feedback)
      FeedbackCreatedJob.stub(:enqueue)

      FeedbackObserver.instance.after_create(feedback)

      FeedbackCreatedJob.should have_received(:enqueue).with(feedback)
    end
  end
end
