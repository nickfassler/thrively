class FeedbackObserver < ActiveRecord::Observer
  observe Feedback

  def after_create(record)
    if record.giver.is_a? User
      HistoryEvent.create(resource: record, user_id: record.giver_id)
    end

    if record.receiver.is_a? User
      HistoryEvent.create(resource: record, user_id: record.receiver_id)
    end
  end
end
