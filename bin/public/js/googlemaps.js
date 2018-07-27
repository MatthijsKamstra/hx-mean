function initGoogleMaps() {
    var el = document.getElementById("map");
    if(el === null) return;
    initMap(el);
}


/**
 * zoom level
 *
 *      1: World
 *      5: Landmass/continent
 *      10: City
 *      15: Streets
 *      20: Buildings
 */

/**
 * this is the starting point of the map (Netherlands)
 * might need to change that to Belgium as well
 * @param {*} el
 */
function initMap(el) {
    // console.log(`initMap - ${el}`);

    var p_lat = 52.132633;
    var p_lng = 5.2912659999999505;
    var p_zoom = 7;

    /**
     * check if the lng/lat-values are set in the page,
     * otherwise use the default (zoom Netherlands)
     */
    if (typeof(lat) !== "undefined" ) {
        // console.log (`lat: ${lat}`);
        p_lat = lat;
        p_zoom = 15;
    }
    if (typeof(lng) !== "undefined" ) {
        // console.log (`lng: ${lng}`);
        p_lng = lng;
        p_zoom = 15;
    }
    var map = new google.maps.Map(el , {
        center: { lat: p_lat, lng: p_lng },
        zoom: p_zoom
    });
}

function setMarker(el){

    // var myLatlng = place.geometry.location;
	// TODO : [mck] need to do this dynamicly
    var myLatlng = {
		"lat":53.21859930000001,
		"lng":5.487331100000006
	};

    console.log('lat: ' + myLatlng.lat);
    console.log('lng: ' + myLatlng.lng);

    var marker = new google.maps.Marker({
      animation: google.maps.Animation.DROP,
      position: myLatlng,
      title: "Hello World!"
    });

    // To add the marker to the map, call setMap();
    marker.setMap(map);
    map.panTo(myLatlng);
    map.setZoom(18);
}
