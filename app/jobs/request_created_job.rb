class RequestCreatedJob < Struct.new(:request_id)
  PRIORITY = 1

  def self.enqueue(request)
    Delayed::Job.enqueue(new(request.id), priority: PRIORITY)
  end

  def perform
    deliver_requested_feedbacks
    create_history_event_for_request_giver
    create_history_event_for_request_invitees
  end

  private

  def deliver_requested_feedbacks
    request.requested_feedbacks.each do |requested_feedback|
      Mailer.request_sent(requested_feedback).deliver
    end
  end

  def create_history_event_for_request_giver
    HistoryEvent.create(resource: request, owner: request.giver)
  end

  def create_history_event_for_request_invitees
    request.invitees.each do |invitee|
      HistoryEvent.create(resource: request, owner: invitee)
    end
  end

  def request
    @request ||= Request.find(request_id)
  end
end
