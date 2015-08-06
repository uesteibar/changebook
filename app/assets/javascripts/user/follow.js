$(document).ready(function() {
  $('.follow-user').on('click', function(event) {
    event.preventDefault();
    var button = $(event.target);
    var userId = button.data('id');
    button.toggleClass('btn-submiting', true);

    var request = $.post('/users/' + userId + '/follow');
    request.done(function(response) {
      button.text(' Following');
      button.toggleClass('btn-submiting', false);
      button.toggleClass('btn-successful', true);
      button.prop("disabled",true);
    });
  });
});
