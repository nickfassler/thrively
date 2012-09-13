class EmailChangedJob < Struct.new(:user_id)
  PRIORITY = 2

  def self.enqueue(user)
    Delayed::Job.enqueue(new(user.id), priority: PRIORITY)
  end

  def perform
    Mailer.email_changed(user).deliver
  end

  private

  def user
    User.find(user_id)
  end
end
