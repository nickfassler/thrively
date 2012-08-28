class HistoryEvent < ActiveRecord::Base
  attr_accessible :resource, :user_id

  belongs_to :resource, polymorphic: true
  belongs_to :user
end
