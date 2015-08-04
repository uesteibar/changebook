function profile_update_initialize() {
  var location = {};
  var input = document.getElementById('gmaps-autocomplete');
  var autocomplete = new google.maps.places.Autocomplete(input, function(location) {});

  google.maps.event.addListener(autocomplete, 'place_changed', function() {
    location = autocomplete.getPlace().geometry.location;
    $('#latitude').val(location.G);
    $('#longitude').val(location.K);
  });

  var selected_genres = [];

  $('#genres-selection').multiselect({
    onChange: function(option, checked, select) {
                if (checked) {
                  selected_genres.push($(option).val());
                } else {
                  selected_genres.splice(selected_genres.indexOf($(option).val()), 1);
                }
            }
  });

  var userId = $('#genres-selection').data('user-id');

  $('option[selected]').each(function(index, el) {
    selected_genres.push($(el).val());
  });

  $('#update-genres').on('click', function(event) {
    event.preventDefault();
    $.post('/users/' + userId + '/liked_genres', {liked_genres_ids: selected_genres});
  });

}
