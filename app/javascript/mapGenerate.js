/**
 * Moves the map to display over Monterrey
 *
 * @param  {H.Map} map      A HERE Map instance within the application
 */
function moveMapToMTY(map){
    map.setCenter({lat:25.6714, lng:-100.309});
    map.setZoom(10);
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
      if (map) moveMapToMTY(map);
    }                  
}