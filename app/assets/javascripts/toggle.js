$(document).ready(function() {
  $('.events .toggle').click(function() {
    $(this).toggleClass('expanded');
    $(this).siblings('.showhide').slideToggle(300);
    $(this).find('i').toggleClass('icon-angle-down').toggleClass('icon-angle-up')
  });
});