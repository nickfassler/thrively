class RequestObserver < ActiveRecord::Observer
  observe Request

  def after_create(record)
    record.create_history_event
    record.requested_feedbacks.each(&:create_history_event)
  end
end
