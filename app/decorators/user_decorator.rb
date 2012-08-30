class UserDecorator < Draper::Base
  decorates :user

  def link_to_profile
    h.link_to(model.email, h.new_feedback_path(user_id: model.id))
  end
end
