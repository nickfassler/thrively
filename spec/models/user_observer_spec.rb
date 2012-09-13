require 'spec_helper'

describe UserObserver do
  describe '#before_validation' do
    it 'associates with invite when given an invite_token' do
      invite = create(:invite)
      user = build_stubbed(:user, invite_token: invite.token)

      UserObserver.instance.before_validation(user)

      user.invite.should == invite
    end
  end

  describe '#after_create' do
    it 'enqueues a UserCreatedJob' do
      user = build_stubbed(:user)
      UserCreatedJob.stub(:enqueue)

      UserObserver.instance.after_create(user)

      UserCreatedJob.should_not have_received(:enqueue)
    end
  end

  describe '#after_update' do
    it 'enqueues EmailChangedJob if email address was changed' do
      user = build(:user)
      user.email = 'changed@example.com'
      EmailChangedJob.stub(:enqueue)

      UserObserver.instance.after_update(user)

      EmailChangedJob.should have_received(:enqueue).with(user)
    end

    it 'does not send an email if email address was unchanged' do
      user = build_stubbed(:user)
      EmailChangedJob.stub(:enqueue)

      UserObserver.instance.after_update(user)

      EmailChangedJob.should_not have_received(:enqueue)
    end
  end
end
