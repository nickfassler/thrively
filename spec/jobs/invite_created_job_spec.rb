require 'spec_helper'

describe InviteCreatedJob do
  describe '.enqueue' do
    it 'enqueues the job' do
      invite = build_stubbed(:invite)

      InviteCreatedJob.enqueue(invite)

      should enqueue_delayed_job('InviteCreatedJob').
        with_attributes(invite_id: invite.id).
        priority(1)
    end
  end

  describe '#perform' do
    it 'emails owner' do
      invite = build_stubbed(:invite)
      Invite.stub(find: invite)
      mailer = double('mailer', deliver: true)
      Mailer.stub(invite_created: mailer)

      InviteCreatedJob.new(invite.id).perform

      Mailer.should have_received(:invite_created).with(invite)
    end
  end
end
