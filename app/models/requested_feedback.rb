class RequestedFeedback < ActiveRecord::Base
  attr_accessible :giver

  belongs_to :giver, polymorphic: true, autosave: true
  belongs_to :request

  validates :giver, presence: true

  def giver_email
    giver.email
  end
end
