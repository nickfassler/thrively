class FeedbackObserver < ActiveRecord::Observer
  observe Feedback

  def after_create(record)
    record.create_history_event
  end
end
