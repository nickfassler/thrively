class GuestDecorator < Draper::Base
  decorates :guest

  def link_to_profile
    model.display_name
  end
end
