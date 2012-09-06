module RequestHelper
  def email_form_fields
    html_options = { class: 'email', placeholder: 'Email', 'data-id' => 0 }
    content_tag :div, class: 'recipients' do
      concat label_tag('emails_0', 'Recipients')

      if @request.emails.empty?
        concat text_field_tag('emails[0]', '', html_options)
      else
        @request.emails.each_with_index do |email, index|
          html_options.update('data-id' => index)
          concat text_field_tag("emails[#{index}]", email, html_options)
        end
      end

      concat link_to('add', '#', id: 'add_recipient')
    end
  end
end
