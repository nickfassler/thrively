class Email
  include ActiveModel::Validations

  attr_accessor :email

  validates :email, presence: true, email: true

  def initialize(email)
    self.email = email
  end
end
