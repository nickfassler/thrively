class RequestedFeedback < ActiveRecord::Base
  attr_accessible :giver

  belongs_to :giver, polymorphic: true
  belongs_to :request

  validates :giver, presence: true
  validates_associated :giver

  def giver_email
    giver.email
  end
end
