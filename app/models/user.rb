class User < ActiveRecord::Base
  include Clearance::User

  attr_accessible :avatar, :email, :invite_token, :password, :name, :username
  attr_accessor :invite_token

  belongs_to :invite
  has_many :requests
  has_many :requested_feedbacks, as: :giver
  has_many :given_feedbacks, as: :giver, class_name: Feedback
  has_many :received_feedbacks, as: :receiver, class_name: Feedback
  has_many :history_events, as: :owner, order: 'created_at DESC'

  validates :name, presence: true
  validates :username, presence: true, uniqueness: true

  has_attached_file :avatar,
    styles: { medium: '80x80#', small: '50x50#' },
    default_url: 'avatar_missing.png'

  def has_remaining_invites?
    remaining_invites > 0
  end

  def sender_of?(resource)
    resource.giver == self
  end

  def convert_from_guest
    guest = Guest.where(email: email).first

    if guest
      transaction do
        self.given_feedbacks = guest.given_feedbacks
        self.received_feedbacks = guest.received_feedbacks
        self.requested_feedbacks = guest.requested_feedbacks
        self.history_events = guest.history_events

        guest.destroy
      end
    end
  end

  def send_thank_you_email(feedback_receiver)
    # no-op
  end
end
