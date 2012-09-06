class UserObserver < ActiveRecord::Observer
  observe User

  def after_create(record)
    guest = Guest.where(email: record.email).first

    if guest
      record.transaction do
        record.given_feedbacks = guest.given_feedbacks
        record.given_feedbacks.each(&:create_history_event)

        record.received_feedbacks = guest.received_feedbacks
        record.received_feedbacks.each(&:create_history_event)

        record.requested_feedbacks = guest.requested_feedbacks
        record.requested_feedbacks.each(&:create_history_event)

        guest.destroy
      end
    end
  end
end
