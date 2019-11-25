function boldify(arr, b, val, i){
    let bold = arr[i].indexOf(val);
    // console.log(bold)
    // b.innerHTML = "<strong>" + arr[i].substr(0, val.length) + "</strong>";
    b.innerHTML = arr[i];
    // b.innerHTML += arr[i].substr(val.length);
}

function setMarker(loc){
  if (window.map){
    let map = window.map;
    // Define a variable holding SVG mark-up that defines an icon image:
    var svgMarkup = `<svg xmlns="http://www.w3.org/2000/svg" width="48" height="48" viewBox="0 0 24 24"><path d="M12 0c-5.522 0-10 4.395-10 9.815 0 5.505 4.375 9.268 10 14.185 5.625-4.917 10-8.68 10-14.185 0-5.42-4.478-9.815-10-9.815zm0 18c-4.419 0-8-3.582-8-8s3.581-8 8-8 8 3.582 8 8-3.581 8-8 8zm4-8v4h-3v-2h-2v2h-3v-4h-1l5-5 5 5h-1zm-1-3l-1-.991v-1.009h1v2z" style="fill: orange;"/></svg>`

    // Create an icon, an object holding the latitude and longitude, and a marker:
    var icon = new H.map.Icon(svgMarkup),
    coords = {lat: loc.latitude, lng: loc.longitude},
    marker = new H.map.Marker(coords, {icon: icon})
    // Add the marker to the map and center the map at the location of the marker:
    map.removeObjects(map.getObjects()) // Removes previous markers
    map.addObject(marker);
    map.setCenter(coords);
    map.setZoom(16);
    // Add values to hidden latitude and longitude form fields
    let latitude = document.getElementById("event_latitude");
    let longitude = document.getElementById("event_longitude");

    latitude.value = loc.latitude;
    longitude.value = loc.longitude;

  }
}

function autocomplete(inp, arr, coord) {
    /*the autocomplete function takes two arguments,
    the text field element and an array of possible autocompleted values:*/
    var currentFocus;
    /*execute a function when someone writes in the text field:*/
    inp.addEventListener("input", function(e) {
        var a, b, i, val = this.value;
        /*close any already open lists of autocompleted values*/
        closeAllLists();
        if (!val) { return false;}
        currentFocus = -1;
        /*create a DIV element that will contain the items (values):*/
        a = document.createElement("DIV");
        a.setAttribute("id", this.id + "autocomplete-list");
        a.setAttribute("class", "autocomplete-items");
        /*append the DIV element as a child of the autocomplete container:*/
        this.parentNode.appendChild(a);
        /*for each item in the array...*/
        for (i = 0; i < arr.length; i++) {
            /*check if the item starts with the same letters as the text field value:*/
            /*create a DIV element for each matching element:*/
            b = document.createElement("DIV");
            // console.log(inp, arr, this);
            /*make the matching letters bold:*/
            boldify(arr,b,val,i);
            /*insert a input field that will hold the current array item's value:*/
            b.innerHTML += "<input type='hidden' value='" + arr[i] + "'>";
            /*execute a function when someone clicks on the item value (DIV element):*/
                b.addEventListener("click", function(e) {
                /*insert the value for the autocomplete text field:*/
                inp.value = this.getElementsByTagName("input")[0].value;
                for (let j = 0; j < coord.length; j++){ //Iterate through coords and find the text
                    let coordText = coord[j].label.replace(/<[^>]*>?/gm, '');
                    if (coordText == inp.value) {
                        const req = new XMLHttpRequest();
                        req.responseType = 'json'
                        const url=`/events/event_get_location_details/${coord[j].locationId}`;
                        
                        req.open("GET", url);
                        req.send();
                        req.onloadend = (e) => {                          
                          let loc = req.response.response.view[0].result[0].location.displayPosition;
                          setMarker(loc);
                        }
                    }
                }
                /*close the list of autocompleted values,
                (or any other open lists of autocompleted values:*/
                closeAllLists();
            });
            a.appendChild(b);
        }
    });
    /*execute a function presses a key on the keyboard:*/
    inp.addEventListener("keydown", function(e) {
        var x = document.getElementById(this.id + "autocomplete-list");
        if (x) x = x.getElementsByTagName("div");
        if (e.keyCode == 40) {
          /*If the arrow DOWN key is pressed,
          increase the currentFocus variable:*/
          currentFocus++;
          /*and and make the current item more visible:*/
          addActive(x);
        } else if (e.keyCode == 38) { //up
          /*If the arrow UP key is pressed,
          decrease the currentFocus variable:*/
          currentFocus--;
          /*and and make the current item more visible:*/
          addActive(x);
        } else if (e.keyCode == 13) {
          /*If the ENTER key is pressed, prevent the form from being submitted,*/
          e.preventDefault();
          if (currentFocus > -1) {
            /*and simulate a click on the "active" item:*/
            if (x) x[currentFocus].click();
          }
        }
    });
    function addActive(x) {
      /*a function to classify an item as "active":*/
      if (!x) return false;
      /*start by removing the "active" class on all items:*/
      removeActive(x);
      if (currentFocus >= x.length) currentFocus = 0;
      if (currentFocus < 0) currentFocus = (x.length - 1);
      /*add class "autocomplete-active":*/
      x[currentFocus].classList.add("autocomplete-active");
    }
    function removeActive(x) {
      /*a function to remove the "active" class from all autocomplete items:*/
      for (var i = 0; i < x.length; i++) {
        x[i].classList.remove("autocomplete-active");
      }
    }
    function closeAllLists(elmnt) {
      /*close all autocomplete lists in the document,
      except the one passed as an argument:*/
      var x = document.getElementsByClassName("autocomplete-items");
      for (var i = 0; i < x.length; i++) {
        if (elmnt != x[i] && elmnt != inp) {
        x[i].parentNode.removeChild(x[i]);
      }
    }
  }
  /*execute a function when someone clicks in the document:*/
  document.addEventListener("click", function (e) {
      closeAllLists(e.target);
  });
  }

const eventSuggestionsListener = () => {

    let textField = document.getElementById("event_location");
    if (textField){
      textField.addEventListener('keyup', event => {
          const req = new XMLHttpRequest();
          req.responseType = 'json'
          const url=`/events/event_location_suggestions/${textField.value}`;
          req.open("GET", url);
          req.send();

          req.onloadend = (e) => {
              if (req.response){
                  let texts = req.response.suggestions.map(m => m.label.replace(/<[^>]*>?/gm, ''));
                  autocomplete(document.getElementById("event_location"), texts, req.response.suggestions);
              }

          }
      })
  }

}

eventSuggestionsListener();