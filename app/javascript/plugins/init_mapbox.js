import mapboxgl from 'mapbox-gl';
import MapboxGeocoder from '@mapbox/mapbox-gl-geocoder';

const mapElement = document.getElementById('map');

const buildMap = () => {
  mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
  return new mapboxgl.Map({
    container: 'map',
    style: 'mapbox://styles/marleygreer/ckf829omt21kz19poy60nc0o9'
  });
};

const addMarkersToMap = (map, markers) => {
 markers.forEach((marker) => {
   const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);
   const element = document.createElement('div');
   element.className = 'marker';
   element.style.backgroundImage = `url('${marker.image_url}')`;
   element.style.backgroundSize = 'contain';
   element.style.width = '26px';
   element.style.height = '26px';

   new mapboxgl.Marker(element)
     .setLngLat([marker.lng, marker.lat])
     .setPopup(popup)
     .addTo(map);
 });
 map.addControl(new MapboxGeocoder({ accessToken: mapboxgl.accessToken,
 mapboxgl: mapboxgl }));
};



const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
  map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
};

const initMapbox = () => {
  if (mapElement) {
    const map = buildMap();
    const markers = JSON.parse(mapElement.dataset.markers);
    addMarkersToMap(map, markers);
    fitMapToMarkers(map, markers);
  }
};




export { initMapbox };
