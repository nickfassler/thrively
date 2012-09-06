require 'spec_helper'

describe FeedbackObserver do
  it 'creates two history events when giver and receiver are both user' do
    expect { create(:feedback) }.to change { HistoryEvent.count }.by(2)
  end

  it 'records creation of feedback for user' do
    feedback = create(:feedback)

    event = HistoryEvent.first
    event.resource_type.should == 'Feedback'
    event.resource_id.should == feedback.id
    HistoryEvent.all.map(&:owner).should == [feedback.giver, feedback.receiver]
  end
end
