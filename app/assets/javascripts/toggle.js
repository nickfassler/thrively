$(document).ready(function() {
  $('.events .toggle').click(function() {
    $(this).toggleClass('expanded');
    $(this).siblings('.showhide').slideToggle(300);
    $(this).find('i').toggleClass('icon-angle-down').toggleClass('icon-angle-up')

    if ($(this).hasClass('expanded'))
      $(this).find('span').text('Collapse')
    else
      $(this).find('span').text('Expand')
  });

  // $('.hide').click(function(){
  //   $(this).hide();
  //   $('#showhide_'+$(this).attr('resource')).hide();
  //   $('#show_'+$(this).attr('resource')).show();
  // });
  // $('.show').click(function(){
  //   $(this).hide();
  //   $('#showhide_'+$(this).attr('resource')).show();
  //   $('#hide_'+$(this).attr('resource')).show();
  // });
});