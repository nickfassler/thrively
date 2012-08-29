require 'spec_helper'

describe RequestObserver do
  it 'records creation of request for each party' do
    request = create(:request)

    HistoryEvent.all.each do |event|
      event = HistoryEvent.first
      event.resource_type.should == 'Request'
      event.resource_id.should == request.id
    end

    HistoryEvent.first.user_id.should == request.user_id
    HistoryEvent.last.user_id.should == request.requested_feedbacks.first.giver.id
  end
end