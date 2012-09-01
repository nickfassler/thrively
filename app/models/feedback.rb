class Feedback < ActiveRecord::Base
  attr_accessible :plus, :delta, :topic, :request_id,
    :receiver_email, :giver_email

  belongs_to :request
  belongs_to :giver, polymorphic: true
  belongs_to :receiver, polymorphic: true

  validates :receiver_id, presence: true
  validates :giver_id, presence: true
  validates :topic, presence: true
  validates :plus, presence: true
  validates :delta, presence: true

  before_validation :copy_attributes_from_request

  def copy_attributes_from_request
    if request
      self.receiver = request.user
      self.topic = request.topic
    end
  end

  def receiver_email
    (request && request.user.email) || receiver.try(:email)
  end

  def receiver_email=(email)
    self.receiver = User.where(email: email).first
    self.receiver ||= Guest.where(email: email).first_or_initialize
  end

  def giver_email=(email)
    self.giver = Guest.where(email: email).first_or_initialize
  end

  def giver_email
    giver.try(:email)
  end

  def receiver?(user)
    receiver == user
  end
end
