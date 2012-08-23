class Feedback < ActiveRecord::Base
  attr_accessible :plus, :delta, :subject, :receiver_attributes

  belongs_to :request
  belongs_to :giver, polymorphic: true
  belongs_to :receiver, polymorphic: true

  validates :receiver, presence: true
  validates :giver, presence: true
  validates :subject, presence: true
  validates :plus, presence: true
  validates :delta, presence: true

  def receiver_attributes=(attributes)
    email = attributes[:email]
    user_or_guest = User.where(email: email).first || Guest.where(email: email).first_or_initialize
    self.receiver = user_or_guest
  end
end
