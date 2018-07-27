// nederland
// lng: 5.2912659999999505
// lat: 52.132633
var map;
var googleMapData = {};

$(document).ready(function() {
    console.log("Register page is ready!");
    init();
});

function init() {
    // console.log("init");

    alertify.parent(document.body);

    // get and set the default values for uid/teacher
    var uid = getParameterByName('uid');
    var isteacher = getParameterByName('isteacher');
    // console.log(`${uid} , ${isteacher}`);

    googleMapData.uid = uid;
    googleMapData.isteacher = isteacher;

	// [mck] make sure that return doesn't activate submit form
	$('.form-no-enter').on('keyup keypress', function(e) {
		var keyCode = e.keyCode || e.which;
		if (keyCode === 13) {
			e.preventDefault();
			return false;
		}
	});

    // activate the button

    $('#submitRegistrationData').hover(function(e){
        // console.log('#submitRegistrationData hover');
        if( !isFormValid(false) ){
            // $('#submitRegistrationData').css("cursor","not-allowed");
            $("#submitRegistrationData").prop('disabled', true);
            $("#submitRegistrationData").addClass('disabled');
        } else {
            // $('#submitRegistrationData').css("cursor","initial");
            $("#submitRegistrationData").prop('disabled', false);
            $("#submitRegistrationData").removeClass('disabled');
        }
    });
    $('#submitRegistrationData').click(function(e){
        e.preventDefault();
        console.log('#submitRegistrationData clicked');
        // make sure every value we need is correct
        if(isFormValid(true)) {
            $.ajax({
                type: 'POST',
                data: JSON.stringify(googleMapData),
                contentType: 'application/json',
                url: '/api/register',
                success: function(data) {
                    console.log('success');
                    console.log(JSON.stringify(data));
                    // {"success":true,"msg":"this is correct","url":"/editor"}
                    location.replace(data.url); // got to the editor (shoppingcard)
                },
                error : function(e) {
                    console.log("ERROR: ", e);
                }
            });
        }
    });

    checkForm();

}

/**
 * TODO : [mck] do some heavy checking here.
 * uid, isteacher, name school, group, School adres (streetname, streetnumber, city, country)
 * check
 */
function isFormValid(useFeedbackBool){
    if (useFeedbackBool === null) useFeedbackBool = false;
    var isFormValidBool = false;

    collectDataFromForm();

    console.log(googleMapData);
    // dit zou niet mogen
    if(googleMapData.isteacher !== 'true'){
        if(useFeedbackBool) alertify.alert("Hmmm geen leraar, misschien klopt dat niet");
        return isFormValidBool;
    }
    if(googleMapData.uid === null || googleMapData.uid === '' ){
        if(useFeedbackBool) alertify.alert("Hmmm geen token, helaas dit gaat niet werken");
        return isFormValidBool;
    }

    // school gegevens en name en group
    if(googleMapData.schoolname.trim() === ''){
        // only check if its not just spacess...
        if(useFeedbackBool) alertify.alert("Kijk nog even goed of je een school naam hebt ingevult");
        return isFormValidBool;
    }
    if(googleMapData.group === null){
        if(useFeedbackBool) alertify.alert("Kijk nog even goed of je een group hebt ingevult");
        return isFormValidBool;
    }

    // city,streetname, streetnumber is from google, so we can check if they exists
    if(googleMapData.city === ''){
        if(useFeedbackBool) alertify.alert("Kijk nog even goed of je een stad hebt ingevult");
        return isFormValidBool;
    }
    if(googleMapData.streetname === ''){
        if(useFeedbackBool) alertify.alert("Kijk nog even goed of je een straatnaam hebt ingevult");
        return isFormValidBool;
    }
    if(googleMapData.streetnumber === ''){
        if(useFeedbackBool) alertify.alert("Kijk nog even goed of je een straat nummer hebt ingevult");
        return isFormValidBool;
    }

    isFormValidBool = true;
    return isFormValidBool;
}

/**
 * run through all fields with `.form-controle`
 * also the hidden parts!
 */
function collectDataFromForm(){
    // var form = document.getElementsByClassName('needs-validation')[0];
    $('.form-control').each(function( index ) {
        // console.log( index + ": " + $( this ).attr('name') +  " - " + $( this ).val() );
        googleMapData[$( this ).attr('name')] = $( this ).val(); // just dump the form in the data set
    });
}

function initGoogleMaps() {
    var el = document.getElementById("map");
    if(el === null) return;
    initMap(el);
    initAutocomplete();
}

function initMap(el) {
    // console.log(`initMap - ${el}`);
    map = new google.maps.Map(el , {
        center: { lat: 52.132633, lng: 5.2912659999999505 },
        zoom: 7
    });
}




// Bias the autocomplete object to the user's geographical location,
// as supplied by the browser's 'navigator.geolocation' object.
function geolocate() {
    if (navigator.geolocation) {
      navigator.geolocation.getCurrentPosition(function(position) {
          var geolocation = {
            lat: position.coords.latitude,
            lng: position.coords.longitude
          };
          var circle = new google.maps.Circle({
            center: geolocation,
            radius: position.coords.accuracy
          });
          autocomplete.setBounds(circle.getBounds());
      });
    }
}

/**
 * ---------------------------------------------------------------
 * utils
 * ---------------------------------------------------------------
 */


/**
 * get query sting values from URL
 *
 * @source https://stackoverflow.com/questions/901115/how-can-i-get-query-string-values-in-javascript
 *
 * @example
 *      // query string: ?foo=lorem&bar=&baz
 *      var foo = getParameterByName('foo'); // "lorem"
 *      var bar = getParameterByName('bar'); // "" (present with empty value)
 *      var baz = getParameterByName('baz'); // "" (present with no value)
 *      var qux = getParameterByName('qux'); // null (absent)
 *
 * @param {*} name
 * @param {*} url
 */
function getParameterByName(name, url) {
    if (!url) url = window.location.href;
    name = name.replace(/[\[\]]/g, "\\$&");
    var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
    results = regex.exec(url);
    if (!results) return null;
    if (!results[2]) return "";
    return decodeURIComponent(results[2].replace(/\+/g, " "));
}


/**
 * ---------------------------------------------------------------
 * form scripts
 * ---------------------------------------------------------------
 */

var placeSearch, autocomplete;
var componentForm = {
    street_number: "short_name",
    route: "long_name",
    locality: "long_name",
    administrative_area_level_1: "long_name",
    country: "long_name",
    postal_code: "short_name"
};

function initAutocomplete() {
    // Create the autocomplete object, restricting the search to geographical location types.
    autocomplete = new google.maps.places.Autocomplete(
      /** @type {!HTMLInputElement} */
	  (document.getElementById("autocomplete")),
      { types: ["geocode"] }
    );

    // When the user selects an address from the dropdown, populate the address fields in the form.
    autocomplete.addListener("place_changed", fillInAddress);
}



function fillInAddress() {
    // Get the place details from the autocomplete object.
    var place = autocomplete.getPlace();

    for (var component in componentForm) {
      document.getElementById(component).value = "";
      document.getElementById(component).disabled = false;
    }

    // Get each component of the address from the place details
    // and fill the corresponding field on the form.
    for (var i = 0; i < place.address_components.length; i++) {
      var addressType = place.address_components[i].types[0];
      if (componentForm[addressType]) {
          var val = place.address_components[i][componentForm[addressType]];
          googleMapData[addressType] = val;
          document.getElementById(addressType).value = val;
      }
    }

    var myLatlng = place.geometry.location;

    console.log('lat: ' + myLatlng.lat());
    console.log('lng: ' + myLatlng.lng());

    var marker = new google.maps.Marker({
      animation: google.maps.Animation.DROP,
      position: myLatlng,
      title: "Hello World!"
    });

    // To add the marker to the map, call setMap();
    marker.setMap(map);
    map.panTo(myLatlng);
    map.setZoom(18);

    // https://coderwall.com/p/hojgtq/auto-center-and-auto-zoom-a-google-map
    // var bounds = new google.maps.LatLngBounds();
    // bounds.extend(myLatlng);
    // map.fitBounds(bounds);      # auto-zoom
    // map.panToBounds(bounds);     # auto-center

    // [mck] start checking after everthing is updated
    console.log(place); // TODO we can store this information in total in DB ....
    checkButtonActive();

    googleMapData.place = JSON.stringify( place );
    googleMapData.formatted_address = place.formatted_address;
    googleMapData.geometry = JSON.stringify( place.geometry );
    googleMapData.lat = myLatlng.lat();
    googleMapData.lng = myLatlng.lng();
    console.log(googleMapData);

}


function checkButtonActive(){
    console.log('checkButtonActive');

    // var forms = document.getElementsByClassName('needs-validation');
	// for (let i = 0; i < forms.length; i++) {
	// 	const form = forms[i];
	// 	form.checkValidity();
	// }


	var arr = ['#route' , '#street_number'];

    // console.log(this);
    var route = $("#route").val(); // straat naam;
    var streetNumber = $("#street_number").val();
    console.log(`#street_number: ${streetNumber}`);
    if( streetNumber !== '' ){
        $("#street_number").removeClass('is-invalid');
    } else {
        $("#street_number").addClass('is-invalid');
    }
    if( route !== '' ){
        $("#route").removeClass('is-invalid');
    } else{
        $("#route").addClass('is-invalid');
    }
}


/**
 * this script is used for the validation of forms by bootstrap
 *
 * AND
 *
 * script to block enter as a valid method for sending data
 *
 * @link https://getbootstrap.com/docs/4.0/components/forms/#custom-styles
 *
 */
function checkForm(){
    // console.log('checkfrom');
    var forms = document.getElementsByClassName('needs-validation');
    // Loop over them and prevent submission
    var validation = Array.prototype.filter.call(forms, function(form) {
		form.addEventListener('submit', function(event) {
			//   console.log('submit button');
			if (form.checkValidity() === false) {
				event.preventDefault();
				event.stopPropagation();
			}
			form.classList.add('was-validated');
		}, false);
    });
};