class Feedback < ActiveRecord::Base
  attr_accessible :plus, :delta, :subject, :receiver_attributes

  belongs_to :request
  belongs_to :giver, polymorphic: true
  belongs_to :receiver, polymorphic: true

  validates :receiver_id, presence: true
  validates :giver_id, presence: true
  validates :subject, presence: true
  validates :plus, presence: true
  validates :delta, presence: true
  validates_associated :receiver, :giver

  def receiver_attributes=(attributes)
    email = attributes[:email]
    user_or_guest = User.where(email: email).first
    user_or_guest ||= Guest.where(email: email).first_or_initialize
    self.receiver = user_or_guest
  end
end
