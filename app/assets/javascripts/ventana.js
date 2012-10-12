saveButton = $("<a href=# class=save>Save</a>").click(function (e) {
  value = $("#editor").val()
  $.ajax({
    type: 'PUT',
    url: '/ventana/editable_contents/' + $(".editable").attr('id'),
    data: {
      value: value
    },
    success: function (resp, respText) {
      $(".editable").html(resp);
      $(".editable").show();
      $("#editor").hide();
      $(".save").hide();
      $(".edit").show();
    },
    error: function (a, b) {
      console.log(b)
    }
  })
  $(".edit").hide();
  e.preventDefault();
}).hide();

$(".edit").after(saveButton);

$(".edit").click(function (e) {
  e.preventDefault();
  editor = $("<textarea id=editor/>")
  width = $(".editable").width();
  height = $(".editable").height();
  $(".editable").hide();
  $(".save").show();
  $(".editable").after("<textarea id=editor/>")
  $("#editor").width(width - 120)
  $("#editor").height(height + 50)
  $.get('/ventana/editable_contents/' + $(".editable").attr('id'), function (resp) {
    $('#editor').val(resp);
  });
  $(".edit").hide();
});


