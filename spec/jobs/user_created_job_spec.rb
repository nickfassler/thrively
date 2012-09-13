require 'spec_helper'

describe UserCreatedJob do
  describe '.enqueue' do
    it 'enqueues the job' do
      user = build_stubbed(:user)

      UserCreatedJob.enqueue(user)

      should enqueue_delayed_job('UserCreatedJob').
        with_attributes(user_id: user.id).
        priority(2)
    end
  end

  describe '#perform' do
    it 'converts guest associations when guest exists' do
      user = build_stubbed(:user)
      User.stub(find: user)
      guest = double(:guest, to_user: nil)
      Guest.stub_chain(:where, first: guest)

      UserCreatedJob.new(user.id).perform

      guest.should have_received(:to_user)
    end

    it 'delivers welcome email' do
      user = build_stubbed(:user)
      User.stub(find: user)
      Mailer.stub_chain(:welcome, :deliver)

      UserCreatedJob.new(user.id).perform

      Mailer.should have_received(:welcome).with(user)
    end
  end
end
