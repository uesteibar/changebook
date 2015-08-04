$(document).ready(function() {
  $('.thank-recommendation').on('click', function(event) {
    event.preventDefault();
    var button = $(event.target);
    var recommendationId = button.data('id');
    button.toggleClass('btn-submiting', true);


    var request = $.post('/recommendations/' + recommendationId + '/thank');
    request.done(function(response) {
      button.text(response + ' thanks');
      button.toggleClass('btn-submiting', false);
      button.toggleClass('btn-successful', true);
      button.prop("disabled",true);
      // $(event.target).toggle(false);
    });
  });
});
