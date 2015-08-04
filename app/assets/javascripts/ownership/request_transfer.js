$(document).ready(function() {
  $('.request-transfer').on('click', function(event) {
    event.preventDefault();
    var button = $(event.target);
    button.toggleClass('btn-submiting', true);
    var ownershipId = button.data('id');

    $.post('/ownerships/' + ownershipId + '/transfers', function(data, textStatus, xhr) {
      button.toggleClass('btn-submiting', false);
      button.toggleClass('btn-successful', true);
      button.text('Sent');
      button.prop("disabled",true);
    });
  });
});
