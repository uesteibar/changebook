$(document).ready(function() {
  $('.thank-recommendation').on('click', function(event) {
    event.preventDefault();
    var recommendationId = $(event.target).data('id');

    var request = $.post('/recommendations/' + recommendationId + '/thank');
    request.done(function(response) {
      $('.thanks-count[data-id=' + recommendationId + ']').text(response + ' thanks');
      $(event.target).toggle(false);
    });
  });
});
