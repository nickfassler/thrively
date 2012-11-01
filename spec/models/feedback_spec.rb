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
    it 'finds or initializes the user or guest by email' do
      user_or_guest = stub('user_or_guest')
      UserOrGuest.stub(new: user_or_guest)
      user_or_guest.stub(find: create(:user))

      feedback = create(:feedback, receiver_email: 'guest@example.com')

      UserOrGuest.should have_received(:new).with('guest@example.com')
      user_or_guest.should have_received(:find)
    end
  end
end
