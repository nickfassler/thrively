class HistoryEventDecorator < Draper::Base
  decorates :history_event

  def html_classes
    classes = [resource.class.name.underscore]

    if model.owner.sender_of?(resource)
      classes << 'sent'
    else
      classes << 'received'
    end
  end

  def icon
    resource_decorator.icon
  end

  def header
    resource_decorator.header(model.owner).html_safe
  end

  def body
    h.content_tag :div, class: 'body' do
      if model.owner.sender_of?(resource)
        h.concat resource.topic
      else
        h.concat resource_decorator.topic
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

  def resource_decorator
    @resource_decorator ||= resource.decorator
  end

  def resource
    @resource ||= history_event.resource
  end
end
