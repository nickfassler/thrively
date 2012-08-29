class Request < ActiveRecord::Base
  attr_accessible :message, :subject, :emails

  belongs_to :user
  has_many :feedbacks
  has_many :requested_feedbacks

  validates :requested_feedbacks, presence: true
  validates :user, presence: true

  def emails=(email_list)
    email_list.each do |_, email|
      if email.present?
        user_or_guest = User.where(email: email).first
        user_or_guest ||= Guest.where(email: email).first_or_initialize
        requested_feedbacks.build(giver: user_or_guest)
      end
    end
  end

  def emails
    requested_feedbacks.map(&:giver_email)
  end
end