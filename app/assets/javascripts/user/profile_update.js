function initialize() {
  var location = {};
  var input = document.getElementById('gmaps-autocomplete');
  var autocomplete = new google.maps.places.Autocomplete(input, function(location) {
    console.log(location);
  });

  google.maps.event.addListener(autocomplete, 'place_changed', function() {
    location = autocomplete.getPlace().geometry.location;
    location = {
      latitude: location.A,
      longitude: location.F
    };
    console.log(location);
  });

  $("form #submit-profile-edit").on('click', function(event) {
    event.preventDefault();
    var id = $('#submit-profile-edit').attr('data');
    var params = {
      id: id,
      user: {
        latitude: location.latitude,
        longitude: location.longitude,
        bio: $('#user_bio').val(),
        avatar: $('#avatar').val()
      }
    };
    if (!location.latitude) {
      geocoder = new google.maps.Geocoder();
      geocoder.geocode({
        'address': $(input).val()
      }, function(results, status) {
        if (status == google.maps.GeocoderStatus.OK) {
          location = results[0].geometry.location;
          location = {
            latitude: location.A,
            longitude: location.F
          };

          params.latitude = location.latitude;
          params.longitude = location.longitude;
        }
      });
    }
    postUser(params);
  });

  var postUser = function(params) {
    console.log(params);
    jQuery.ajax({
      url: '/users/' + params.id,
      type: "PUT",
      dataType: "json",
      data: params,
      success: function(result) {
        window.location = '/users/' + params.id;
      }
    });
  }
}
