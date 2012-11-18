$('#user_avatar_url').change ->
  url = $('#user_avatar_url').val()
  $('.avatar img').attr('src', url)
