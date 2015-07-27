function profile_update_initialize() {
  var location = {};
  var input = document.getElementById('gmaps-autocomplete');
  var autocomplete = new google.maps.places.Autocomplete(input, function(location) {});

  google.maps.event.addListener(autocomplete, 'place_changed', function() {
    location = autocomplete.getPlace().geometry.location;
    $('#latitude').val(location.A);
    $('#longitude').val(location.F);
  });
}
