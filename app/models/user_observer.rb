class UserObserver < ActiveRecord::Observer
  observe User

  def before_validation(record)
    if record.invite_token
      record.invite = Invite.where(token: record.invite_token).first!
    end
  end

  def after_create(record)
    guest = Guest.where(email: record.email).first

    if guest
      record.transaction do
        record.given_feedbacks = guest.given_feedbacks
        record.received_feedbacks = guest.received_feedbacks
        record.requested_feedbacks = guest.requested_feedbacks
        record.history_events = guest.history_events

        guest.destroy
      end
    end
  end
end
