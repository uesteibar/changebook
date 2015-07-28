var BookOwnershipManager = function() {};

BookOwnershipManager.prototype.init = function () {
  $('#new-offer').on('submit', function(event) {
    event.preventDefault();
    inputs = $(event.target).serializeArray();
    var params = {
      book_id: bookId
    };

    inputs.forEach(function(input) {
      if (input.name == 'to-give-away') {
        params.to_give_away = true;
      } else if (input.name == 'to-exchange') {
        params.to_exchange = true;
      }
    });

    var request = $.post('/ownerships', {
      ownership: params
    });
    request.always(function(res) {
      window.location.reload();
    });
  });
};

module.exports = new BookOwnershipManager();
