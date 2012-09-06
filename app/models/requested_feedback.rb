class RequestedFeedback < ActiveRecord::Base
  attr_accessible :giver

  belongs_to :giver, polymorphic: true
  belongs_to :request

  validates :giver_id, presence: true

  def giver_email
    giver.try(:email)
  end

  def giver_name
    giver.try(:name)
  end

  def notify
    Mailer.request_sent(self).deliver
  end
end
