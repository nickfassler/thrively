require 'spec_helper'

describe Request do
  it { should have_db_column(:created_at) }
  it { should have_db_column(:updated_at) }

  it { should_not allow_mass_assignment_of(:created_at) }
  it { should_not allow_mass_assignment_of(:updated_at) }
  it { should_not allow_mass_assignment_of(:user_id) }

  it { should validate_presence_of(:requested_feedbacks) }
  it { should validate_presence_of(:user) }

  describe '.emails' do
    it 'is a list of emails of guests or users' do
      guest = create(:guest)
      user = create(:user)
      request = create(:request, emails: { '0' => guest.email, '1' => user.email })

      request.emails.should include(guest.email, user.email)
    end
  end
end
