function initialize() {
  var input = document.getElementById('gmaps-autocomplete');
  var autocomplete = new google.maps.places.Autocomplete(input, function(location) {
    console.log(location);
  });

  google.maps.event.addListener(autocomplete, 'place_changed', function() {
    var location = autocomplete.getPlace().geometry.location;
    location = {
      latitude: location.A,
      longitude: location.F
    };
    console.log(location);
  });
}

google.maps.event.addDomListener(window, 'load', initialize);
