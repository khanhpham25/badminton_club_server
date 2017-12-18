setTimeout(function() {
  $('.alert').fadeOut('slow');
}, 5000);

$(document).on('turbolinks:load', function() {
  if ($('#user-tables_wrapper').length == 1) {
    $('#user-tables_wrapper').destroy();
  }
  $('#user-tables').DataTable();

  function readURL(input) {
    if (input.files && input.files[0]) {
      var reader = new FileReader();

      reader.onload = function (e) {
        $('#img_prev').attr('src', e.target.result);
      }
      reader.readAsDataURL(input.files[0]);
    }
  }

  $("#avatar-upload").change(function(){
    readURL(this);
  });
});
