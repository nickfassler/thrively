require 'spec_helper'

describe Invite do
  it { should have_db_column(:created_at) }
  it { should have_db_column(:updated_at) }

  it { should_not allow_mass_assignment_of(:created_at) }
  it { should_not allow_mass_assignment_of(:token) }
  it { should_not allow_mass_assignment_of(:updated_at) }
  it { should_not allow_mass_assignment_of(:user_id) }

  it { should validate_presence_of(:email) }

  it do
    should_not validate_format_of(:email).with('user@example').
      with_message(/is not an email/)
  end

  it { should validate_format_of(:email).with('user@example.com') }

  describe '.create' do
    it 'enqueues a InviteCreatedJob' do
      InviteCreatedJob.stub(:enqueue)
      invite = create(:invite)
      InviteCreatedJob.should have_received(:enqueue).with(invite)
    end

    it 'sets a token' do
      invite = create(:invite)
      invite.token.should_not be_nil
    end
  end
end
