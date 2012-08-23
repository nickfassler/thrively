class RequestedFeedback < ActiveRecord::Base
  attr_accessible :email

  belongs_to :user, foreign_key: :email, primary_key: :email
  belongs_to :request

  validates :email, presence: true, format: { with: %r{^[a-z0-9!#\$%&'*+\/=?^_`{|}~-]+(?:\.[a-z0-9!#\$%&'*+\/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?$}i }
end
