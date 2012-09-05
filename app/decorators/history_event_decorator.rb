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

  def icon
    resource_decorator.icon
  end

  def header
    resource_decorator.header(model.user).html_safe
  end

  def body
    h.content_tag :div, class: 'body' do
      if resource.respond_to?(:sender?) && resource.sender?(model.user)
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
