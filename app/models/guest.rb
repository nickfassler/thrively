class Guest < ActiveRecord::Base
  attr_accessible :email

  has_many :given_feedbacks, as: :giver, class_name: Feedback,
    dependent: :destroy
  has_many :history_events, as: :owner, dependent: :destroy
  has_many :received_feedbacks, as: :receiver, class_name: Feedback,
    dependent: :destroy
  has_many :requested_feedbacks, as: :giver, dependent: :destroy

  validates :email, presence: true, email: true

  def avatar
    NullAvatar.new
  end

  def name
    email
  end

  def to_user
    user = User.where(email: email).first

    if user
      user.given_feedbacks = given_feedbacks
      user.received_feedbacks = received_feedbacks
      user.requested_feedbacks = requested_feedbacks
      user.history_events = history_events
      reload
      destroy
    else
      raise 'Cannot convert because user record does not exist'
    end

    user
  end
end
