import places from 'places.js';

const placesAutocomplete = (appId, apiKey) => {
  const addressInput = document.getElementById('user_address');
  const latInput = document.getElementById('user_lat');
  const lonInput = document.getElementById('user_lon');
  if (addressInput) {
    let p = places({
      container: addressInput,
      appId: appId,
      apiKey: apiKey,
    }).configure({
      language: 'fr',
      countries: ['fr']
    });
    p.on('change', function(e) {
      let latlng = e.suggestion.latlng;
      latInput.value = latlng['lat'];
      lonInput.value = latlng['lng'];
    });
  }
  const addressInputMap = document.getElementById('map_address');
  const latInputMap = document.getElementById('map_lat');
  const lonInputMap = document.getElementById('map_lon');
  if (addressInputMap) {
    let p = places({
      container: addressInputMap,
      appId: appId,
      apiKey: apiKey,
    }).configure({
      language: 'fr',
      countries: ['fr']
    });
    p.on('change', function(e) {
      let latlng = e.suggestion.latlng;
      latInputMap.value = latlng['lat'];
      lonInputMap.value = latlng['lng'];
    });
  }
};

export { placesAutocomplete };