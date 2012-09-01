class RequestDecorator < Draper::Base
  decorates :request

  def header(current_user)
    if model.sender?(current_user)
      text = "You requested feedback from: "

      profile_links = model.invitees.map do |invitee|
        invitee.decorator.link_to_profile
      end

      text += profile_links.join(', ')
    else
      "Received feedback request from #{model.user.decorator.link_to_profile}"
    end
  end

  def topic
    h.content_tag :div do
      h.link_to(
        model.topic, h.new_feedback_path(feedback: { request_id: model.id }))
    end
  end
end
