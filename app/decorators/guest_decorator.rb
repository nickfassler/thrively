class GuestDecorator < Draper::Base
  decorates :guest

  def link_to_profile
    guest.email
  end
end
