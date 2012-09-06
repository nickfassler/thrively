class FeedbackObserver < ActiveRecord::Observer
  observe Feedback

  def after_create(record)
    HistoryEvent.create(resource: record, owner: record.giver)
    HistoryEvent.create(resource: record, owner: record.receiver)
  end
end
