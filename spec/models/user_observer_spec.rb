require 'spec_helper'

describe UserObserver do
  describe '#before_validation' do
    it 'associates with invite when given an invite_token' do
      invite = create(:invite)

      user = create(:user, invite_token: invite.token)

      user.invite.should == invite
    end
  end

  describe '#after_create' do
    it 'converts given feedbacks from guest' do
      guest = create(:guest)
      given_feedback = create(:feedback, giver: guest)

      user = create(:user, email: guest.email)

      user.given_feedbacks.should == [given_feedback]
    end

    it 'converts received feedbacks from guest' do
      guest = create(:guest)
      received_feedback = create(:feedback, receiver: guest)

      user = create(:user, email: guest.email)

      user.received_feedbacks.should == [received_feedback]
    end

    it 'converts requested_feedbacks from guest' do
      guest = create(:guest)
      requested_feedback = create(:requested_feedback, giver: guest)

      user = create(:user, email: guest.email)

      user.requested_feedbacks.should == [requested_feedback]
    end

    it 'deletes the guest' do
      guest = create(:guest)

      create(:user, email: guest.email)

      expect { guest.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end

    it 'generates history events' do
      guest = create(:guest)
      given_feedback = create(:feedback, giver: guest)
      received_feedback = create(:feedback, receiver: guest)
      request = create(:request, emails: [guest.email])

      user = create(:user, email: guest.email)

      user.should have(3).history_events
    end
  end
end
