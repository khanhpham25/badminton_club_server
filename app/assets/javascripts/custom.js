setTimeout(function() {
  $('.alert').fadeOut('slow');
}, 5000);

$(document).on('turbolinks:load', function() {
  $('#user-tables').DataTable();
});
