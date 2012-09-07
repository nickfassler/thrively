require 'spec_helper'

describe User do
  it { should have_db_column(:created_at) }
  it { should have_db_column(:updated_at) }

  it { should_not allow_mass_assignment_of(:created_at) }
  it { should_not allow_mass_assignment_of(:updated_at) }

  it { should belong_to(:invite) }
  it { should have_many(:requests) }
  it { should have_many(:requested_feedbacks) }
  it { should have_many(:given_feedbacks) }
  it { should have_many(:received_feedbacks) }
  it { should have_many(:history_events) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:username) }

  describe '#has_remaining_invites?' do
    it 'is true when invites remain' do
      user = build_stubbed(:user, remaining_invites: 1)

      user.should have_remaining_invites
    end
  end

  describe '#covert_from_user' do
    it 'converts given feedbacks from guest' do
      guest = create(:guest)
      given_feedback = create(:feedback, giver: guest)
      user = build(:user, email: guest.email)

      user.convert_from_guest

      user.given_feedbacks.should == [given_feedback]
    end

    it 'converts received feedbacks from guest' do
      guest = create(:guest)
      received_feedback = create(:feedback, receiver: guest)
      user = build(:user, email: guest.email)

      user.convert_from_guest

      user.received_feedbacks.should == [received_feedback]
    end

    it 'converts requested_feedbacks from guest' do
      guest = create(:guest)
      requested_feedback = create(:requested_feedback, giver: guest)
      user = build(:user, email: guest.email)

      user.convert_from_guest

      user.requested_feedbacks.should == [requested_feedback]
    end

    it 'deletes the guest' do
      guest = create(:guest)
      user = build(:user, email: guest.email)

      user.convert_from_guest

      expect { guest.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'generates history events' do
      guest = create(:guest)
      given_feedback = create(:feedback, giver: guest)
      received_feedback = create(:feedback, receiver: guest)
      request = create(:request, emails: [guest.email])
      user = build(:user, email: guest.email)

      user.convert_from_guest

      user.should have(3).history_events
    end
  end
end
