class InviteCreatedJob < Struct.new(:invite_id)
  PRIORITY = 2

  def self.enqueue(invite)
    Delayed::Job.enqueue(new(invite.id), priority: PRIORITY)
  end

  def perform
    Mailer.invite_created(invite).deliver
  end

  private

  def invite
    Invite.find(invite_id)
  end
end
