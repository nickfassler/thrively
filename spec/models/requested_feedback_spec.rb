require 'spec_helper'

describe RequestedFeedback do
  it { should have_db_column(:created_at) }
  it { should have_db_column(:updated_at) }

  it { should_not allow_mass_assignment_of(:created_at) }
  it { should_not allow_mass_assignment_of(:updated_at) }
  it { should_not allow_mass_assignment_of(:request_id) }
  it { should_not allow_mass_assignment_of(:giver_id) }

  it { should validate_presence_of(:giver_id) }

  describe '#create_history_event' do
    it 'creates a history event for feedback giver' do
      requested_feedback = build(:requested_feedback)

      expect { requested_feedback.create_history_event }.to change { HistoryEvent.count }.by(1)
      HistoryEvent.last.user.should == requested_feedback.giver
    end
  end
end
