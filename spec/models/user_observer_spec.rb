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
    it 'converts guest associations when guest exists' do
      user = build_stubbed(:user)
      guest = double(:guest, to_user: nil)
      Guest.stub_chain(:where, first: guest)

      UserObserver.instance.after_create(user)

      guest.should have_received(:to_user)
    end

    it 'sends a welcome email' do
      user = build_stubbed(:user)
      Mailer.stub_chain(:welcome, :deliver)
      UserObserver.instance.after_create(user)

      Mailer.should have_received(:welcome).with(user)
    end
  end

  describe '#after_update' do
    it 'sends an email if email address was changed' do
      user = build_stubbed(:user)
      user.email = 'changed@example.com'
      Mailer.stub_chain(:email_changed, :deliver)

      UserObserver.instance.after_update(user)

      Mailer.should have_received(:email_changed).with(user)
    end

    it 'does not send an email if email address was unchanged' do
      user = create(:user)
      Mailer.stub(:email_changed, :deliver)

      UserObserver.instance.after_update(user)

      Mailer.should_not have_received(:email_changed).with(user)
    end
  end
end
