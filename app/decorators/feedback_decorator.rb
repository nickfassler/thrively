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
    h.content_tag :div, class: 'user' do
      h.concat h.image_tag('http://placehold.it/60x60', class: 'img-polaroid')
      h.concat "Email: #{model.receiver_email}"
    end
  end

  def topic
    h.content_tag :div, model.topic
  end
end
