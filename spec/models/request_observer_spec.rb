require 'spec_helper'

describe RequestObserver do
  describe '#after_create' do
    it 'enqueues a RequestCreatedJob' do
      request = build_stubbed(:request)
      RequestCreatedJob.stub(:enqueue)

      RequestObserver.instance.after_create(request)

      RequestCreatedJob.should have_received(:enqueue).with(request)
    end
  end
end
