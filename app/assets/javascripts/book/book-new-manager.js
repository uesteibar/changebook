var BookCreationManager = function() {};

BookCreationManager.prototype.init = function () {

  $('#search-results').on('click', '#new-book', function(event) {
    event.preventDefault();
    $('#create-book').modal('show');
  });

  $('body').on('submit', '.new-book', function(event) {
    event.preventDefault();
    $('#create-book').modal('hide');
    $('body').removeClass('modal-open');
    $('.modal-backdrop').remove();
  });
};

module.exports = new BookCreationManager();
