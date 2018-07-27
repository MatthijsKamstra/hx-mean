// start with empty array
var locations = [];
var map;


/**
 * starting point from the Google Map api perspective
 */
function initGoogleMaps (){
    // console.log('could use this to init the map');
    // [mck] now we know that google maps is active!
    init();
}

/**
 * starting point from the DOM perspective
 */
$(document).ready(function() {
    console.log("Hompage is ready!");
    if(map === undefined) return;
    init();
});

/**
 * homepage has the data generated into the page...
 * so depends on server for the data
 *      - trashResult
 *      - userResult
 *      - shoppingList
 */
function init () {
    // console.log("trashResult: " , trashResult);
    // console.log("userResult: " , userResult);
    // console.log("shoppingList: " , shoppingList);
    convertUserData (userResult);
    convertTrashData (trashResult);
    initMarkerCluster(locations);
}

/**
 * https://developers.google.com/maps/documentation/javascript/marker-clustering
 */
function initMarkerCluster(pLocations){

    map = new google.maps.Map(document.getElementById('map'), {
        center: { lat: 52.132633, lng: 5.2912659999999505 },
        zoom: 7
    });

    // Create an array of alphabetical characters used to label the markers.
    var labels = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

    // Add some markers to the map.
    // Note: The code uses the JavaScript Array.prototype.map() method to
    // create an array of markers based on a given "locations" array.
    // The map() method here has nothing to do with the Google Maps API.
    var markers = pLocations.map(function(location, i) {
        return new google.maps.Marker({
            position: location,
            label: labels[i % labels.length]
        });
    });

    // Add a marker clusterer to manage the markers.
    var markerCluster = new MarkerClusterer(
        map,
        markers,
        {imagePath: 'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m'}
    );

}

/**
 * this is all the trash data is stored
 * make it work for the map and different lists
 *
 * @param {json} resultJson     data from all the trash collection (Belgium and Netherlands)
 */
function convertTrashData (resultJson){
    // console.log(resultJson);

    locations = []; // {lat: 52.370216, lng: 4.895168}, // reset data

    var totalTrashCount = 0;
    var count = 0;
    var trashMap = new Map();
    // var brandNameMap = new Map();

    for (let i = 0; i < resultJson.length; i++) {
        const resultItem = resultJson[i];

        var dataJson = JSON.parse(JSON.stringify(resultItem.data));
        // console.log(dataJson);

        for (const item in dataJson) {
            if (dataJson.hasOwnProperty(item)) {
                // this is probably obsolete
                // if(item === 'question') {
                //     const element = dataJson[item];
                //     // see if there are more brands split by comma
                //     var brandNameArray = element.split(',');
                //     for (let j = 0; j < brandNameArray.length; j++) {
                //         const brandName = brandNameArray[j].trim().toLowerCase();
                //         if (brandNameMap.has(brandName)){
                //             var temp = brandNameMap.get(brandName);
                //             brandNameMap.set(brandName,temp +1);
                //         } else {
                //             brandNameMap.set(brandName,1);
                //         }
                //     }
                //     break;
                // }

                // old code (might be in some databases), just ignore
                if(item === 'question') {
                    break;
                }
                const totalCount = dataJson[item]; // total nr of item fount (for example: 10 flessen)
                // console.log(resultItem);
                // console.log(item);
                // console.log(totalCount);
                count += parseInt(totalCount); // count every item in on variable
                // console.log(count);
                totalTrashCount += parseInt(totalCount); // overal total number trash
                // console.log(totalTrashCount);

                // so not a question, so count everything
                if (trashMap.has(item)){
                    var temp = trashMap.get(item);
                    trashMap.set(item,temp + totalCount);
                } else {
                    trashMap.set(item,1);
                }

                // create makers for EVERY piece of trash found
                const obj = {
                    'lat': Number(resultItem.lat),
                    'lng': Number(resultItem.lng),
                    'total' : totalCount
                };
                locations.push (obj);

            }
        }
    }
    // console.log(locations);

    // var brandSortMap = new Map( [...brandNameMap.entries()].sort((a, b) => b[1] - a[1] ) );
    var trashSortMap = new Map( [...trashMap.entries()].sort((a, b) => b[1] - a[1] ) );

    // var htmlTable = '';
    // var count = 1;
    // var max = 5;
    // for (var [key, value] of brandSortMap) {
    //     // console.log(key + ' = ' + value);
    //     htmlTable += `<tr><th scope="row">${count}</th><td>${key}</td><td>${value}</td></tr>`;
    //     if(count >= max) break;
    //     count++;
    // }
    // $("#brand-lijst").html(htmlTable);

    var htmlTable = '';
    var arr = [];
    var count = 1;
    var max = 5;
    for (var [key, value] of trashSortMap) {
        // console.log(key + ' = ' + value);
        htmlTable += `<tr><th scope="row">${count}</th><td>${key}</td><td>${value}</td></tr>`;
        arr.push({'id':key, 'value':value});
        if(count >= max) break;
        count++;
    }
    $("#trash-lijst").html(htmlTable);

    $(".container-plastic:eq(0)").html(dataToPlasticComponent(arr[0]));
    $(".container-plastic:eq(1)").html(dataToPlasticComponent(arr[1]));
    $(".container-plastic:eq(2)").html(dataToPlasticComponent(arr[2]));


    $("#trashdata-total").html('totaal aantal keer ingevult: ' + resultJson.length );
    $(".trashdata-count").html( setCorrectDot (totalTrashCount) );
    $("#trashdata-count").html('totaal items gevonden: ' + totalTrashCount );
}

/**
 * convert data to component
 *
 * @param obj {'id':key, 'value':value}
 */
function dataToPlasticComponent (obj){
    var html = '';
    if(obj === undefined) obj = {'value':'0', 'id': 'oeps'};
    for (let i = 0; i < shoppingList.length; i++) {
        const element = shoppingList[i];
        if(element.id === obj.id){
            html += `<img src="${element.image}">`;
            html += `<span class="count">${setCorrectDot(obj.value)}</span>`;
            html += `<span class="description">${element.description}</span>`;
        }
    }
    return html;
}

/**
 * convert data to component
 *
 * @param obj {'id':key, 'value':value}
 */
function dataToCityComponent (obj){
    var html = '';
    if(obj === undefined) obj = {'value':'0', 'id': '...'};
    html += `<span class="count">${setCorrectDot(obj.value)}</span>`;
    html += `<span class="description">${obj.id}</span>`;
    return html;
}


/**
 * perhaps we need to add a dot in the number:
 * 11572 -> 11.572
 *
 * @example:
 *      console.log (setCorrectDot(10));
 *      console.log (setCorrectDot(100));
 *      console.log (setCorrectDot(1000));
 *      console.log (setCorrectDot(10000));
 *      console.log (setCorrectDot(totalTrashCount));
 */
function setCorrectDot(value){
    var str = `${value}`;
    if(str.length > 3){
        str = str.substring(0,str.length - 3) + '.' + str.substring(str.length - 3);
    }
    return str;
}

/**
 * convert the json to data that can be used in the homepage
 * @param {*} resultJson
 */
function convertUserData (resultJson){
    var provincieMap  = new Map();
    var schoolMap  = new Map();
    var cityMap  = new Map();

    for (let i = 0; i < resultJson.length; i++) {
        const item = resultJson[i];
        const _provincie = item.provincie;
        const _schooladdress = item.formatted_address;
        const _city = item.city;

        // provincie
        if (provincieMap.has(_provincie)){
            var temp = provincieMap.get(_provincie);
            provincieMap.set(_provincie,temp + 1);
        } else {
            provincieMap.set(_provincie,1);
        }

        // school address
        if (schoolMap.has(_schooladdress)){
            var temp2 = schoolMap.get(_schooladdress);
            schoolMap.set(_schooladdress,temp2 + 1);
        } else {
            schoolMap.set(_schooladdress,1);
        }

        // city
        if (cityMap.has(_city)){
            var temp3 = cityMap.get(_city);
            cityMap.set(_city,temp3 + 1);
        } else {
            cityMap.set(_city,1);
        }
    }

    // console.log('total nr provincies: ',provincieMap.size);
    // console.log('provincieMap:',provincieMap);
    var mapAsc = new Map( [...provincieMap.entries()].sort((a,b) => a[0] > b[0]) );
    // console.log('mapAsc',mapAsc);
    var mapDesc = new Map( [...provincieMap.entries()].sort());
    // console.log('mapDesc',mapDesc);
    // var mapSortProvincie = new Map( [...provincieMap.entries()].sort((a, b) => a[1] <= b[1]) );
    var mapSortProvincie = new Map( [...provincieMap.entries()].sort((a, b) => b[1] - a[1] ) );
    // console.log('mapSortProvincie',mapSortProvincie);

    // console.log('schoolMap:',schoolMap);
    var mapSortSchool = new Map( [...schoolMap.entries()].sort((a, b) => b[1] - a[1] ) );
    // console.log('mapSortSchool:',mapSortSchool);

    var mapSortCity = new Map( [...cityMap.entries()].sort((a, b) => b[1] - a[1] ) );

    var htmlTable = '';
    var count = 1;
    var max = 5;
    for (var [key, value] of mapSortProvincie) {
        // console.log(key + ' = ' + value);
        htmlTable += `<tr><th scope="row">${count}</th><td>${key}</td><td>${value}</td></tr>`;
        if(count >= max) break;
        count++;
    }
    $("#provincie-lijst").html(htmlTable);

    var htmlTable = '';
    var count = 1;
    var max = 5;
    for (var [key, value] of mapSortSchool) {
        // console.log(key + ' = ' + value);
        htmlTable += `<tr><th scope="row">${count}</th><td>${key}</td><td>${value}</td></tr>`;
        if(count >= max) break;
        count++;
    }
    $("#groep-lijst").html(htmlTable);

    var htmlTable = '';
    var arr = [];
    var count = 1;
    var max = 5;
    for (var [key, value] of mapSortCity) {
        // console.log(key + ' = ' + value);
        htmlTable += `<tr><th scope="row">${count}</th><td>${key}</td><td>${value}</td></tr>`;
        arr.push({'id':key, 'value':value});
        if(count >= max) break;
        count++;
    }
    $("#trash-lijst").html(htmlTable);

    $(".container-counter:eq(0)").html(dataToCityComponent(arr[0]));
    $(".container-counter:eq(1)").html(dataToCityComponent(arr[1]));
    $(".container-counter:eq(2)").html(dataToCityComponent(arr[2]));



    $("#userdata-provincies").html('aantal provincies die mee doen: ' + provincieMap.size);
    $("#userdata-users").html('aantal ingeschreven leraren: ' + resultJson.length );

    $("#userdata-schools").html('aantal ingeschreven scholen: ' + schoolMap.size );
    $(".userdata-schools").html(schoolMap.size);

}