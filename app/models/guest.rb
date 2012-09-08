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

  def send_thank_you_email(feedback_receiver)
    Mailer.thank_you(self, feedback_receiver).deliver
  end

  def to_user
    user = User.where(email: email).first

    if user
      transaction do
        user.given_feedbacks = given_feedbacks
        user.received_feedbacks = received_feedbacks
        user.requested_feedbacks = requested_feedbacks
        user.history_events = history_events

        destroy
      end
    else
      raise 'Cannot convert because user record does not exist'
    end

    user
  end
end
