class UserDecorator < Draper::Base
  decorates :user

  def link_to_profile
    h.link_to(user.display_name, h.new_feedback_path(user_id: user.id))
  end
end
