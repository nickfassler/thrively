class HistoryEventDecorator < Draper::Base
  decorates :history_event

  def html_classes
    classes = ['well', resource.class.name.underscore]

    if resource.respond_to?(:receiver)
      if resource.receiver == model.user
        classes << 'received'
      else
        classes << 'sent'
      end
    elsif resource.respond_to?(:user)
      if resource.user == model.user
        classes << 'sent'
      else
        classes << 'received'
      end
    end

    classes
  end

  def header
    if resource.respond_to?(:receiver)
      if resource.receiver == model.user
        "#{resource.class} from #{resource.giver.email}"
      else
        "#{resource.class} to #{resource.receiver.email}"
      end
    elsif resource.respond_to?(:user)
      if resource.user == model.user
        "You requested feeback from: #{resource.requested_feedbacks.map(&:giver_email).join(', ')}"
      else
        "#{resource.user.email} requests feedback from you"
      end
    end
  end

  def body
    h.content_tag :div do
      if resource.respond_to?(:subject)
        h.concat h.content_tag :div, resource.subject
      end
      if resource.respond_to?(:message)
        h.concat h.content_tag :div, resource.message
      end
      if resource.respond_to?(:plus)
        h.concat h.content_tag :div, resource.plus
      end
      if resource.respond_to?(:delta)
        h.concat h.content_tag :div, resource.delta
      end
    end
  end

  private

  def resource
    history_event.resource
  end
end
