require 'spec_helper'

describe Request do
  it { should have_db_column(:created_at) }
  it { should have_db_column(:updated_at) }

  it { should_not allow_mass_assignment_of(:created_at) }
  it { should_not allow_mass_assignment_of(:updated_at) }
  it { should_not allow_mass_assignment_of(:user_id) }

  it { should have_many(:feedbacks).dependent(:destroy) }
  it { should have_many(:requested_feedbacks).dependent(:destroy) }
  it { should belong_to(:user) }

  it { should validate_presence_of(:user) }

  describe '#save' do
    it 'validates when valid emails present' do
      request = build(:request)

      request.save

      request.should be_valid
    end

    it 'fails to validate when no emails present' do
      request = build(:request_without_requested_feedbacks, emails: [''])

      request.save

      request.should_not be_valid
    end

    it 'fails to validate when invalid emails' do
      request = build(:request_without_requested_feedbacks,
        emails: ['bad@email'])

      request.save

      request.should_not be_valid
    end
  end

  describe '#emails' do
    it 'is a list of emails of guests or users' do
      guest = create(:guest)
      user = create(:user)
      request = create(:request, emails: [guest.email, user.email])

      request.emails.should include(guest.email, user.email)
    end
  end
end
