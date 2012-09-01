class UserDecorator < Draper::Base
  decorates :user

  def link_to_profile
    h.link_to(model.email, h.profile_path(user_id: model.id))
  end
end
