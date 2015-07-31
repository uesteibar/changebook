var BookOwnershipManager = function() {};

BookOwnershipManager.prototype.init = function() {
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

BookOwnershipManager.prototype.initUpdate = function() {
  var ownershipId = 0;
  $('.open-update-ownership').on('click', function(event) {
    event.preventDefault();
    ownershipId = event.target.dataset.id;
    console.log(ownershipId);
    $('#update-ownership').modal('show');
  });

  $('#updated-offer').on('submit', function(event) {
    event.preventDefault();
    inputs = $(event.target).serializeArray();

    var params = {};

    inputs.forEach(function(input) {
      if (input.name == 'to-give-away') {
        params.to_give_away = true;
      } else if (input.name == 'to-exchange') {
        params.to_exchange = true;
      }
    });

    $.ajax({
      url: '/ownerships/' + ownershipId,
      type: 'PUT',
      data: {
        ownership: params
      },
      success: function(result) {
        window.location.reload();
      }
    });
  });
};

module.exports = new BookOwnershipManager();
