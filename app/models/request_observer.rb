class RequestObserver < ActiveRecord::Observer
  observe Request

  def after_create(record)
    HistoryEvent.create(resource: record, user_id: record.user_id)

    record.requested_feedbacks.each(&:create_history_event)
  end
end
