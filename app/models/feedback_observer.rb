class FeedbackObserver < ActiveRecord::Observer
  observe Feedback

  def after_create(feedback)
    FeedbackCreatedJob.enqueue(feedback)
  end
end
