class FeedbackObserver < ActiveRecord::Observer
  observe Feedback

  def after_create(feedback)
    HistoryEvent.create(resource: feedback, owner: feedback.giver)
    HistoryEvent.create(resource: feedback, owner: feedback.receiver)

    Mailer.feedback_given(feedback).deliver
    feedback.giver.send_thank_you_email(feedback.receiver)
  end
end
