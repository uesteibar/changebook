function profile_show_initialize() {
  $('#follow-user').on('click', function(event) {
    event.preventDefault();
    var request = $.ajax({
      url: '/users/' + event.target.dataset.id + '/follow',
      method: "POST"
    });

    request.done(function(data) {
      window.location.reload();
    });
  });

  $('#unfollow-user').on('click', function(event) {
    event.preventDefault();
    var request = $.ajax({
      url: '/users/' + event.target.dataset.id + '/unfollow',
      method: "DELETE"
    });

    request.done(function(data) {
      window.location.reload();
    });
  });
}
