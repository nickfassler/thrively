$(document).ready(function() {
  $('.hide').click(function(){
    $(this).hide();
    $('#showhide_'+$(this).attr('resource')).hide();
    $('#show_'+$(this).attr('resource')).show();
  });
  $('.show').click(function(){
    $(this).hide();
    $('#showhide_'+$(this).attr('resource')).show();
    $('#hide_'+$(this).attr('resource')).show();
  });
});