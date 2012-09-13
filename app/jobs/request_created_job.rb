class RequestCreatedJob < Struct.new(:request_id)
  PRIORITY = 1

  def self.enqueue(request)
    Delayed::Job.enqueue(new(request.id), priority: PRIORITY)
  end

  def perform
    deliver_feedback_requests
  end

  private

  def deliver_feedback_requests
    request.requested_feedbacks.each do |requested_feedback|
      Mailer.request_sent(requested_feedback).deliver
    end
  end

  def request
    Request.find(request_id)
  end
end
