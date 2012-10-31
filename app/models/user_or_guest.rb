class UserOrGuest
  attr_reader :email

  def initialize(email)
    @email = email.downcase
  end

  def find
    User.where(email: email).first ||
    Guest.where(email: email).first_or_initialize
  end
end
