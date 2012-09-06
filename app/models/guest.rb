class Guest < ActiveRecord::Base
  attr_accessible :email

  validates :email, presence: true, email: true
  has_many :given_feedbacks, as: :giver, class_name: Feedback
  has_many :received_feedbacks, as: :receiver, class_name: Feedback
  has_many :requested_feedbacks, as: :giver
  has_many :history_events, as: :owner

  def name
    email
  end
end
