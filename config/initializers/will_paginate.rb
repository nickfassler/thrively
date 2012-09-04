module WillPaginate
  module ActionView
    def will_paginate(collection = nil, options = {})
      options[:renderer] ||= BootstrapLinkRenderer
      super.try :html_safe
    end

    class BootstrapLinkRenderer < LinkRenderer
      protected

      def html_container(html)
        tag :div, tag(:ul, html), container_attributes
      end

      def page_number(page)
        if page == current_page
          tag(:li, page, class: 'active')
        else
          link(page, page, :rel => rel_value(page))
        end
      end

      def previous_or_next_page(page, text, classname)
        if page
          tag :li, link(text, page, class: classname)
        else
          tag :li, text, class: classname + ' disabled'
        end
      end
    end
  end
end
