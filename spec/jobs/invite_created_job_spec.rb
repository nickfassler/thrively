require 'spec_helper'

describe InviteCreatedJob do
  context 'self.enqueue' do
    before do
      @invite = build_stubbed(:invite)
      InviteCreatedJob.enqueue(@invite)
    end

    it do
      should enqueue_delayed_job('InviteCreatedJob').
        with_attributes(invite_id: @invite.id).
        priority(1)
    end
  end

  context 'perform' do
    before do
      @invite = build_stubbed(:invite)
      Invite.stub(find: @invite)
      mailer = double('mailer', deliver: true)
      Mailer.stub(invite_created: mailer)
      InviteCreatedJob.new(@invite.id).perform
    end

    it 'emails owner' do
      Mailer.should have_received(:invite_created).with(@invite)
    end
  end
end
