class FeedbackCreatedJob < Struct.new(:feedback_id)
  PRIORITY = 1

  def self.enqueue(feedback)
    Delayed::Job.enqueue(new(feedback.id), priority: PRIORITY)
  end

  def perform
    create_history_event_for_feedback_giver
    delete_old_request_history_event_for_feedback_giver
    create_history_event_for_feedback_receiver
    deliver_feedback
    deliver_thank_you_to_guest_feedback_giver
  end

  private

  def create_history_event_for_feedback_giver
    HistoryEvent.create(resource: feedback, owner: feedback.giver)
  end

  def delete_old_request_history_event_for_feedback_giver
    if feedback.request
      HistoryEvent.for(feedback.request, feedback.giver).delete
    end
  end

  def create_history_event_for_feedback_receiver
    HistoryEvent.create(resource: feedback, owner: feedback.receiver)
  end

  def deliver_feedback
    Mailer.feedback_given(feedback).deliver
  end

  def deliver_thank_you_to_guest_feedback_giver
    if feedback.giver.is_a?(Guest)
      Mailer.thank_you(feedback).deliver
    end
  end

  def feedback
    @feedback ||= Feedback.find(feedback_id)
  end
end
