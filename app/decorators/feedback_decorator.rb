class FeedbackDecorator < Draper::Base
  decorates :feedback

  def header(current_user)
    if current_user.sender_of?(feedback)
      "#{Feedback} given to #{feedback.receiver.decorator.link_to_profile}"
    else
      "#{Feedback} received from #{feedback.giver.decorator.link_to_profile}"
    end
  end

  def html_for_receiver_email
    user = feedback.requester || feedback.receiver
    h.content_tag :div, class: 'user' do
      h.concat h.image_tag(user.avatar.url(:medium))
      h.concat user.display_name
    end
  end

  def topic
    h.content_tag :div, feedback.topic
  end

  def icon
    h.content_tag :i, nil, class: 'icon-retweet'
  end
end
