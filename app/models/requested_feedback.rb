class RequestedFeedback < ActiveRecord::Base
  attr_accessible :giver

  belongs_to :giver, polymorphic: true
  belongs_to :request

  validate :validates_giver

  def giver_email
    giver.try(:email)
  end

  def giver_name
    giver.try(:name)
  end

  def requester
    request.user
  end

  def requester_name
    requester.name
  end

  def requester_email
    requester.email
  end

  private

  def validates_giver
    if giver.id.nil?
      giver.errors.add :emails, 'Invalid'
      errors.add :base, 'Giver email is invalid'
    end
  end
end
