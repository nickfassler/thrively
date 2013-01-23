
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


# JQuery Tags Input

onAddTag = (tag) ->
  alert "Added a tag: " + tag
onRemoveTag = (tag) ->
  alert "Removed a tag: " + tag
onChangeTag = (input, tag) ->
  alert "Changed a tag: " + tag
$ ->
  $("#tags_1").tagsInput width: "auto"
  $("#tags_2").tagsInput
    width: "auto"
    onChange: (elem, elem_tags) ->
      languages = ["php", "ruby", "javascript"]
      $(".tag", elem_tags).each ->
        $(this).css "background-color", "yellow"  if $(this).text().search(new RegExp("\\b(" + languages.join("|") + ")\\b")) >= 0

  $("#tags_3").tagsInput
    width: "auto"
    
    #autocomplete_url:'test/fake_plaintext_endpoint.html' //jquery.autocomplete (not jquery ui)
    autocomplete_url: "test/fake_json_endpoint.html" # jquery ui autocomplete requires a json endpoint

# Uncomment this line to see the callback functions in action
#     $('input.tags').tagsInput({onAddTag:onAddTag,onRemoveTag:onRemoveTag,onChange: onChangeTag});
# Uncomment this line to see an input with no interface for adding new tags.
#     $('input.tags').tagsInput({interactive:false});