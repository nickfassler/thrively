module ApplicationHelper
  def chosen_input_html(options = {})
    options.merge({ class: 'chzn-select', 'data-placeholder' => 'Select' })
  end

  def chosen_wrapper_html
    { class: 'chosen-wrapper' }
  end
end
