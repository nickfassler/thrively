require 'spec_helper'

describe EmailChangedJob do
  describe '.enqueue' do
    it 'enqueues the job' do
      user = build_stubbed(:user)

      EmailChangedJob.enqueue(user)

      should enqueue_delayed_job('EmailChangedJob').
        with_attributes(user_id: user.id).
        priority(2)
    end
  end

  describe '#perform' do
    it 'delivers email changed email to user' do
      user = build_stubbed(:user)
      User.stub(find: user)
      Mailer.stub_chain(:email_changed, :deliver)

      EmailChangedJob.new(user.id).perform

      Mailer.should have_received(:email_changed).with(user)
    end
  end
end
