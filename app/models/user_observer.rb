class UserObserver < ActiveRecord::Observer
  observe User

  def before_validation(user)
    if user.invite_token
      user.invite = Invite.where(token: user.invite_token).first!
    end
  end

  def after_create(user)
    user.convert_from_guest

    Mailer.welcome(user).deliver
  end

  def after_update(user)
    if user.email_changed?
      Mailer.email_changed(user).deliver
    end
  end
end
