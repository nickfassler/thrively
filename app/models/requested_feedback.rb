class RequestedFeedback < ActiveRecord::Base
  attr_accessible :giver

  belongs_to :giver, polymorphic: true
  belongs_to :request

  validates :giver_id, presence: true

  def giver_email
    giver.email
  end

  def create_history_event
    if giver.is_a? User
      HistoryEvent.create(resource: request, user_id: giver.id)
    end
  end

  def notify
    Mailer.request_sent(request, giver).deliver
  end
end
