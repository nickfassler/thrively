class HistoryEvent < ActiveRecord::Base
  attr_accessible :resource, :owner

  belongs_to :owner, polymorphic: true
  belongs_to :resource, polymorphic: true

  self.per_page = 10

  def name_for(user)
    resource_name = resource_type.downcase

    if resource.giver == user
      "#{resource_name}_sent"
    else
      "#{resource_name}_received"
    end
  end

  def self.for(resource, owner)
    where(
      resource_type: resource.class,
      resource_id: resource.id,
      owner_type: owner.class,
      owner_id: owner.id
    ).first
  end
end
