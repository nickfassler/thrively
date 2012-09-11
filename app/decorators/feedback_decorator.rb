class FeedbackDecorator < Draper::Base
  decorates :feedback

  def html_for_receiver_email
    user = feedback.requester || feedback.receiver
    h.content_tag :div, class: 'user' do
      h.concat h.image_tag(user.avatar.url(:medium))
      h.concat user.name
    end
  end
end
