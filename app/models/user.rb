class User < ActiveRecord::Base
  include Clearance::User

  attr_accessible :email, :password

  has_many :requests
  has_many :requested_feedbacks, through: :requests
  has_many :given_feedbacks, as: :giver, class_name: Feedback
  has_many :history_events, order: 'created_at DESC'

  def stream_events(page)
    history_events.
      order('created_at DESC').
      includes(:resource, :user).
      page(page)
  end
end
