class FeedbackDecorator < Draper::Base
  decorates :feedback

  def header(current_user)
    if model.receiver?(current_user)
      "#{model.class} from #{model.giver.decorator.link_to_profile}"
    else
      "#{model.class} to #{model.receiver.decorator.link_to_profile}"
    end
  end

  def html_for_receiver_email
    user = model.requester || model.receiver
    h.content_tag :div, class: 'user' do
      h.concat h.image_tag(user.avatar.url(:medium))
      h.concat user.display_name
    end
  end

  def topic
    h.content_tag :div, model.topic
  end

  def icon
    h.content_tag :i, nil, class: 'icon-retweet'
  end
end
