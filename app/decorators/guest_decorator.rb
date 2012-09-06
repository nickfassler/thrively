class GuestDecorator < Draper::Base
  decorates :guest

  def link_to_profile
    guest.display_name
  end
end
