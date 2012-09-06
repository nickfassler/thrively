class HistoryEvent < ActiveRecord::Base
  attr_accessible :resource, :owner

  belongs_to :resource, polymorphic: true
  belongs_to :owner, polymorphic: true

  self.per_page = 10
end
