class Invite < ActiveRecord::Base
  attr_accessible :email

  belongs_to :user, counter_cache: true

  validates :email, presence: true, email: true

  before_validation :set_token
  after_create :enqueue_job

  private

  def set_token
    self.token = SecureRandom.hex(8)
  end

  def enqueue_job
    InviteCreatedJob.enqueue(self)
  end
end
