class Request < ActiveRecord::Base
  attr_accessible :emails, :message, :topic

  has_many :feedbacks, dependent: :destroy
  has_many :requested_feedbacks, dependent: :destroy
  belongs_to :user, counter_cache: true

  validate :validates_emails
  validates :user, presence: true

  def emails=(email_list)
    email_list.select do |email|
      Email.new(email).valid?
    end.each do |email|
      user_or_guest = User.where(email: email).first
      user_or_guest ||= Guest.where(email: email).first_or_create
      requested_feedbacks.build(giver: user_or_guest)
    end
  end

  def emails
    requested_feedbacks.map(&:giver_email)
  end

  def invitees
    requested_feedbacks.includes(:giver).map(&:giver).compact
  end

  def giver
    user
  end

  def user_name
    user.name
  end

  private

  def validates_emails
    if requested_feedbacks.empty?
      errors.add(:emails)
    end
  end
end
