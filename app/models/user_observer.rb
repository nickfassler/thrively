class UserObserver < ActiveRecord::Observer
  observe User

  def before_validation(user)
    if user.invite_token
      user.invite = Invite.where(token: user.invite_token).first!
    end
  end

  def after_create(user)
    UserCreatedJob.enqueue(user)
  end

  def after_update(user)
    if user.email_changed?
      EmailChangedJob.enqueue(user)
    end
  end
end
