require 'spec_helper'

describe HistoryEvent do
  it { should have_db_column(:created_at) }
  it { should have_db_column(:updated_at) }

  it { should_not allow_mass_assignment_of(:created_at) }
  it { should_not allow_mass_assignment_of(:updated_at) }

  it { should belong_to(:owner) }
  it { should belong_to(:resource) }

  it { should validate_presence_of(:owner) }
  it { should validate_presence_of(:resource) }

  describe '#name_for' do
    it 'is feedback_sent when user sent feedback' do
      feedback = build_stubbed(:feedback)
      history_event = build_stubbed(:history_event, resource: feedback)
      history_event.name_for(feedback.giver).should == 'feedback_sent'
    end

    it 'is feedback_received when user received feedback' do
      feedback = build_stubbed(:feedback)
      history_event = build_stubbed(:history_event, resource: feedback)
      history_event.name_for(feedback.receiver).should == 'feedback_received'
    end

    it 'is request_sent when user sent request' do
      request = build_stubbed(:request)
      history_event = build_stubbed(:history_event, resource: request)
      history_event.name_for(request.giver).should == 'request_sent'
    end

    it 'is request_received when user received request' do
      request = build(:request)
      history_event = build_stubbed(:history_event, resource: request)
      history_event.name_for(Guest.new).should == 'request_received'
    end
  end

  describe '.for' do
    it 'finds history event by resource and owner' do
      history_event = create(:history_event)

      HistoryEvent.for(history_event.resource, history_event.owner).should ==
        history_event
    end
  end
end
