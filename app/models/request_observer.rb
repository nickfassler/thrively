class RequestObserver < ActiveRecord::Observer
  observe Request

  def after_create(record)
    HistoryEvent.create(resource: record, owner: record.user)

    record.requested_feedbacks.each do |requested_feedback|
      HistoryEvent.create(
        resource: requested_feedback.request,
        owner: requested_feedback.giver
      )
    end
  end
end
