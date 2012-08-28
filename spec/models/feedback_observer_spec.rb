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
    event.user_id.should == feedback.giver_id
    HistoryEvent.last.user_id.should == feedback.receiver_id
  end

  it 'does not record creation of feedback for guest' do
    expect {
      create(:feedback, giver: create(:guest), receiver: create(:guest))
    }.to_not change { HistoryEvent.count }
  end
end
