# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

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
