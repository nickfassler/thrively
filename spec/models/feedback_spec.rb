require 'spec_helper'

describe Feedback do
  it { should have_db_column(:created_at) }
  it { should have_db_column(:updated_at) }

  it { should_not allow_mass_assignment_of(:created_at) }
  it { should_not allow_mass_assignment_of(:updated_at) }
  it { should_not allow_mass_assignment_of(:giver_id) }
  it { should_not allow_mass_assignment_of(:receiver_id) }

  it { should belong_to(:giver) }
  it { should have_many(:history_events).dependent(:destroy) }
  it { should belong_to(:receiver) }
  it { should belong_to(:request) }

  it { should validate_presence_of(:receiver) }
  it { should validate_presence_of(:giver) }
  it { should validate_presence_of(:topic) }
  it { should validate_presence_of(:plus) }
  it { should validate_presence_of(:delta) }

  describe '#receiver_email=' do
    it 'creates receiver as guest for never seen email' do
      feedback = create(:feedback, receiver_email: 'guest@example.com')
      feedback.receiver.should be_a Guest
    end

    it 'assigns receiver as user for existing user email' do
      feedback = Feedback.new(receiver_email: create(:user).email)
      feedback.receiver.should be_a User
    end

    it 'preserves feedback requester as receiver ignoring receiver_email' do
      request = create(:request)
      feedback = create(:feedback, request: request, receiver_email: 'guest@example.com')
      feedback.receiver.should == request.user
    end
  end
end
