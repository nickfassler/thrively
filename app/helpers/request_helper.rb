module RequestHelper
  def email_form_fields
    content_tag :div do
      concat label_tag 'emails_0', 'Recipients'

      if @request.emails.empty?
        concat text_field_tag 'emails[0]', '', class: 'email', placeholder: 'Email'
      else
        @request.emails.each_with_index do |email, index|
          concat text_field_tag "emails[#{index}]", email, class: 'email', placeholder: 'Email'
        end
      end

      concat link_to 'add', '#', id: 'add_recipient'
    end
  end
end
