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
end
