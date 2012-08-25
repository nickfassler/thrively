# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
nextEmailId = 0

$('#add_recipient').bind 'click', ->
  element = $('input.email').last()
  nextEmailId++
  clonedElement = element.clone()
  clonedElement.attr
    'id': 'email_' + nextEmailId,
    'name': 'emails[' + nextEmailId + ']',
    'value': ''
  element.after clonedElement
  clonedElement.focus()
