require 'spec_helper'

describe Guest do
  it { should have_db_column(:created_at) }
  it { should have_db_column(:updated_at) }

  it { should_not allow_mass_assignment_of(:created_at) }
  it { should_not allow_mass_assignment_of(:updated_at) }

  it {
    should_not validate_format_of(:email).with('user@example').
      with_message(/is not an email/)
  }
  it { should validate_format_of(:email).with('user@example.com') }

  describe '#avatar' do
    it 'is a NullAvatar' do
      Guest.new.avatar.should be_kind_of(NullAvatar)
    end
  end

  describe '#to_user' do
    it 'converts given feedbacks' do
      converted_user_with_association(:feedback, :giver).
        should have(1).given_feedback
    end

    it 'converts received feedbacks' do
      converted_user_with_association(:feedback, :receiver).
        should have(1).received_feedback
    end

    it 'converts requested feedbacks' do
      converted_user_with_association(:requested_feedback, :giver).
        should have(1).requested_feedback
    end

    it 'converts history events' do
      guest = create(:guest)
      history_event_one = create(:history_event, owner: guest)
      history_event_two = create(:history_event, owner: guest)
      guest.reload

      ActiveRecord::Base.observers.disable :user_observer do
        create(:user, email: guest.email)
      end

      guest.to_user.history_events.should ==
        [history_event_one, history_event_two]
    end

    it 'deletes the guest' do
      guest = create(:guest)
      create(:user, email: guest.email)

      guest.to_user

      expect { guest.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end

    private

    def converted_user_with_association(resource_sym, role)
      guest = build_stubbed(:guest)
      guest.stub(:destroy)
      create(resource_sym, role => guest)

      ActiveRecord::Base.observers.disable :user_observer do
        create(:user, email: guest.email)
      end

      guest.to_user
    end
  end
end
