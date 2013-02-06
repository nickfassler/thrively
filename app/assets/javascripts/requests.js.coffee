$(->

  $('#request_emails').tagsInput(
    height:'26px',
    width:'504px',
    defaultText:'Add one or more emails',
    placeholderColor:'#999999',
    interactive:true,
    removeWithBackspace: true,
    autocomplete_url:"users/1/friends_autocomplete.json",
    autocomplete:{minLength:1}
  )

  $("input#request_emails_tag").focus(->
    $(this).parent("div").parent("div").addClass("tagsinput_focus")
  ).blur ->
    $(this).parent("div").parent("div").removeClass("tagsinput_focus")

)
