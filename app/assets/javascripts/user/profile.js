function profile_show_initialize() {
  $('#follow-user').on('click', function(event) {
    event.preventDefault();
    var request = $.ajax({
      url: "/users/following",
      method: "POST",
      data: {
        followed_id: event.target.dataset.id
      },
      dataType: "json"
    });

    request.done(function(data) {
      console.log(data);
    });
  });
}
