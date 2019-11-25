/**
 * Moves the map to display over Monterrey
 *
 * @param  {H.Map} map      A HERE Map instance within the application
 */
function moveMapToCenter(map, mapHTML){
  if (mapHTML.hasAttribute("lat") && mapHTML.hasAttribute("lon")){
    let latitude = mapHTML.getAttribute("lat");
    let longitude = mapHTML.getAttribute("lon");
    // Define a variable holding SVG mark-up that defines an icon image:
    var svgMarkup = `<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" viewBox="0 0 24 24"><path d="M12 0c-5.522 0-10 4.395-10 9.815 0 5.505 4.375 9.268 10 14.185 5.625-4.917 10-8.68 10-14.185 0-5.42-4.478-9.815-10-9.815zm0 18c-4.419 0-8-3.582-8-8s3.581-8 8-8 8 3.582 8 8-3.581 8-8 8zm4-8v4h-3v-2h-2v2h-3v-4h-1l5-5 5 5h-1zm-1-3l-1-.991v-1.009h1v2z" style="fill: orange;"/></svg>`

    // Create an icon, an object holding the latitude and longitude, and a marker:
    var icon = new H.map.Icon(svgMarkup),
    coords = {lat: latitude, lng: longitude},
    marker = new H.map.Marker(coords, {icon: icon})
    // Add the marker to the map and center the map at the location of the marker:
    map.removeObjects(map.getObjects()) // Removes previous markers
    map.addObject(marker);
    map.setCenter(coords);
    map.setZoom(16);
  } else {
    map.setCenter({lat:25.6714, lng:-100.309});
    map.setZoom(10);
  }
}
  
  /**
   * Boilerplate map initialization code starts below:
   */
  
  //Step 1: initialize communication with the platform
  // In your own code, replace variable window.apikey with your own apikey
  var platform = new H.service.Platform({
    apikey: "UX4N12G2hxJt_QW-KEAKMCc_XsSs_N0dO59il_rsg6s"
  });
  var defaultLayers = platform.createDefaultLayers();
  
  let mapHTML = document.getElementById("here-map");
  if (mapHTML){
    //Step 2: initialize a map - this map is centered over Monterrey
    var map = new H.Map(mapHTML,
      defaultLayers.vector.normal.map,{
      center: {lat:25.6714, lng:-100.309},
      zoom: 10,
      pixelRatio: window.devicePixelRatio || 1
    });
    window.map = map;
    // add a resize listener to make sure that the map occupies the whole container
    window.addEventListener('resize', () => map.getViewPort().resize());
    
    //Step 3: make the map interactive
    // MapEvents enables the event system
    // Behavior implements default interactions for pan/zoom (also on mobile touch environments)
    var behavior = new H.mapevents.Behavior(new H.mapevents.MapEvents(map));
    // Create the default UI components
    var ui = H.ui.UI.createDefault(map, defaultLayers);
    // Now use the map as required...
    window.onload = function () {
      if (map) moveMapToCenter(map, mapHTML);
    }                  
}