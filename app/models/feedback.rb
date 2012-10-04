class Feedback < ActiveRecord::Base
  attr_accessible :plus, :delta, :topic, :request_id,
    :receiver_email, :giver_email

  belongs_to :request
  belongs_to :giver, polymorphic: true, counter_cache: true
  belongs_to :receiver, polymorphic: true

  validates :receiver, presence: true
  validates :giver, presence: true
  validates :topic, presence: true
  validates :plus, presence: true
  validates :delta, presence: true

  before_validation :copy_attributes_from_request

  def copy_attributes_from_request
    if request
      self.receiver = requester
      self.topic = request.topic
    end
  end

  def receiver_email
    (request && requester.email) || receiver.try(:email)
  end

  def receiver_email=(email)
    return if email.blank?
    self.receiver = User.where(email: email).first
    self.receiver ||= Guest.where(email: email).first_or_initialize
  end

  def receiver_name
    receiver.try(:name)
  end

  def giver_email=(email)
    self.giver = Guest.where(email: email).first_or_initialize
  end

  def giver_email
    giver.try(:email)
  end

  def giver_name
    giver.try(:name)
  end

  def requester
    request.try(:user)
  end
end
