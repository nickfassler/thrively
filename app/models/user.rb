class User < ActiveRecord::Base
  include Clearance::User

  attr_accessible :avatar, :email, :invite_token, :name, :password, :username
  attr_accessor :invite_token

  has_many :given_feedbacks, as: :giver, class_name: Feedback,
    dependent: :destroy
  has_many :history_events, as: :owner, dependent: :destroy
  belongs_to :invite
  has_many :received_feedbacks, as: :receiver, class_name: Feedback,
    dependent: :destroy
  has_many :requests, dependent: :destroy
  has_many :requested_feedbacks, as: :giver, dependent: :destroy

  validates :name, presence: true
  validates :username, presence: true, uniqueness: true

  has_attached_file :avatar,
    styles: { medium: '80x80#', small: '50x50#' },
    default_url: 'avatar_missing.png'

  def friends_emails
    (feedback_receiver_emails + feedback_giver_emails + request_emails).
      flatten.
      compact.
      sort.
      uniq
  end

  def has_remaining_invites?
    remaining_invites > 0
  end

  def stream
    history_events.includes(:resource, :owner).order('created_at DESC')
  end

  private

  def feedback_receiver_emails
    given_feedbacks.map(&:receiver_email)
  end

  def feedback_giver_emails
    received_feedbacks.map(&:giver_email)
  end

  def request_emails
    requests.map(&:emails)
  end
end
