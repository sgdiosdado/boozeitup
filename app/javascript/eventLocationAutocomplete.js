const eventSuggestionsListener = () => {

    textField = document.getElementById("event_location");

    textField.addEventListener('keyup', event => {
        const req = new XMLHttpRequest();
        req.responseType = 'json'
        const url=`/events/event_location_suggestions/${textField.value}`;
        req.open("GET", url);
        req.send();

        req.onload = (e) => {
            console.log(req.response)
        }
    })

}

eventSuggestionsListener();