class RequestDecorator < Draper::Base
  decorates :request

  def header(current_user)
    if current_user.sender_of?(request)
      text = "You requested feedback from "

      profile_links = request.invitees.map do |invitee|
        invitee.decorator.link_to_profile
      end

      text += profile_links.join(', ')
    else
      "#{request.user.decorator.link_to_profile} requested feedback from you"
    end
  end

  def topic
    h.content_tag :div, class: 'topic' do
      h.link_to(
        request.topic,
        h.new_feedback_path(feedback: { request_id: request.id })
      )
    end
  end

  def icon
    h.content_tag :i, nil, class: 'icon-bullhorn'
  end
end
