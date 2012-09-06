class Invite < ActiveRecord::Base
  attr_accessible :email

  belongs_to :user

  validates :email, presence: true

  before_validation :set_token
  after_create :enqueue_invite_created_job

  private

  def set_token
    self.token = SecureRandom.hex(8)
  end

  def enqueue_invite_created_job
    InviteCreatedJob.enqueue self
  end
end
