class User < ActiveRecord::Base
  include Clearance::User

  attr_accessible :email, :password, :avatar, :first_name, :last_name

  has_many :requests
  has_many :requested_feedbacks, as: :giver
  has_many :given_feedbacks, as: :giver, class_name: Feedback
  has_many :received_feedbacks, as: :receiver, class_name: Feedback
  has_many :history_events, as: :owner, order: 'created_at DESC'

  has_attached_file :avatar,
    styles: { medium: '80x80#', small: '50x50#' },
    default_url: 'avatar_missing.png'

  def display_name
    if first_name.present?
      if last_name.present?
        "#{first_name} #{last_name}"
      else
        first_name
      end
    elsif last_name.present?
      last_name
    else
      email
    end
  end

  def sender_of?(resource)
    resource.giver == self
  end
end
