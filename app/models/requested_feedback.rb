class RequestedFeedback < ActiveRecord::Base
  attr_accessible :giver

  belongs_to :giver, polymorphic: true
  belongs_to :request

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

  def generate_hash   
    require 'digest/sha1'
    salt = "gysh1p2pojfox5tali1zub"
    Digest::SHA1.hexdigest "#{salt}-#{id}"
  end

end
