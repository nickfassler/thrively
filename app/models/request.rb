class Request < ActiveRecord::Base
  attr_accessible :message, :subject, :user_id, :requested_feedbacks_attributes

  belongs_to :user
  has_many :requested_feedbacks
  has_many :users, through: :requested_feedbacks
  has_many :feedbacks

  accepts_nested_attributes_for :requested_feedbacks
end
