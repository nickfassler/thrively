$(->
  # Harvest Chosen (written by ThoughtBot)
  $('#add_recipient').bind 'click', ->
    element = $('input.email').last()
    nextEmailId = element.data('id')
    nextEmailId++
    clonedElement = element.clone()
    clonedElement.attr
      'id': 'email_' + nextEmailId,
      'name': 'emails[' + nextEmailId + ']',
      'value': '',
      'data-id': nextEmailId
    element.after clonedElement
    clonedElement.focus()

  $('#email_tags').tagsInput(
    height:'100px',
    width:'529px',
    interactive:true,
    removeWithBackspace: true,
    autocomplete_url:"users/1/friends_autocomplete.json",
    autocomplete:{minLength:2}
  )
)