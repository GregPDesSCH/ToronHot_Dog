/*
    ToronHot Dog
    Frontend - Application Behavior Code

    This JavaScript file provides the major frontend functionality of this web app. It consists of various
    listeners and functions for HTTP requests, as well as data to be considered by the form this app presents
    to the frontend user.

    VERSION 1.0
    Start Date: March 17, 2018
    End Date: April , 2018

    File Name: toronhot_dog.js

    Original Source Code © 2018 Gregory Desrosiers. All rights reserved.
*/


// Dictionary of all the possible options the user can select when they want to use
// a range that's in the metric system. All the values of these pairs are in kilometers
const METRIC_VALUES = {
  "No Range": 0,        // No range limit
  "10 m": 0.01,
  "50 m": 0.05,
  "100 m": 0.1,
  "1/4 km": 0.25,
  "1/2 km": 0.5,
  "1 km": 1,
  "2 km": 2,
  "5 km": 5,
}

// Dictionary of all the possible options the user can select when they want to use
// a range that's in the imperial system. All the values of these pairs are in miles.
const IMPERIAL_VALUES = {
  "No Range": 0,
  "50 ft": 0.0094697,
  "100 ft": 0.0189394,
  "200 ft": 0.0378788,
  "500 ft": 0.094697,
  "1/4 mi": 0.25,
  "1/2 mi": 0.5,
  "1 mi": 1,
  "2 mi": 2,
  "4 mi": 4
};

// Dictionary of all the major intersections where the user can choose one at their convenience.
// These hold actual coordinates to respect the Google Maps API and the functions in the backend
// that calculate the distance between two points.
const MAJOR_INTERSECTIONS = {
  // Queens Quay on Toronto's Waterfront
  "Queens Quay" : {
    "Queens Quay / Lower Sherbourne Street": {latitude: 43.645176, longitude: -79.365437},
    "Queens Quay / Lower Jarvis Street": {latitude: 43.643997, longitude: -79.369029},
    "Queens Quay / Yonge Street": {latitude: 43.641974, longitude: -79.374635},
    "Queens Quay / Bay Street": {latitude: 43.641185, longitude: -79.376868},
    "Queens Quay / York Street": {latitude: 43.640063, longitude: -79.380155},
    "Queens Quay / Bay Street": {latitude: 43.639619, longitude: -79.382793},
    "Queens Quay / Lower Simcoe Street": {latitude: 43.639619, longitude: -79.382793},
    "Queens Quay / Spadina Avenue": {latitude: 43.637743, longitude: -79.391906},
    "Queens Quay / Bathrust Street": {latitude: 43.636524, longitude: -79.399658}
  },
  // Front Street, the street that goes across Union Station, one of the main entrances to the
  // Toronto Metro Convention Centre, and a few other attractions.
  "Front Street" : {
    "Front Street / Lower Sherbourne Street": {latitude: 43.650384, longitude: -79.367921},
    "Front Street / Jarvis Street": {latitude: 43.649402, longitude: -79.371405},
    "Front Street / Yonge Street": {latitude: 43.646888, longitude: -79.376965},
    "Front Street / Bay Street": {latitude: 43.646009, longitude: -79.379111},
    "Front Street / York Street": {latitude: 43.645218, longitude: -79.382504},
    "Front Street / Simcoe Street": {latitude: 43.644763, longitude: -79.385015},
    "Front Street / Spadina Avenue": {latitude: 43.642741, longitude: -79.393836},
    "Front Street / Bathrust Street": {latitude: 43.638893, longitude: -79.400610}
  },
  // King Street, Toronto's most busiest street through the use of light rail.
  "King Street" : {
    "King Street / Sherbourne Street": {latitude: 43.651276, longitude: -79.368257},
    "King Street / Jarvis Street": {latitude: 43.650438, longitude: -79.371910},
    "King Street / Yonge Street": {latitude: 43.649160, longitude: -79.377877},
    "King Street / Bay Street": {latitude: 43.648627, longitude: -79.380240},
    "King Street / University Avenue": {latitude: 43.647653, longitude: -79.384850},
    "King Street / Simcoe Street": {latitude: 43.647395, longitude: -79.386085},
    "King Street / Spadina Avenue": {latitude: 43.645487, longitude: -79.394900},
    "King Street / Bathrust Street": {latitude: 43.643882, longitude: -79.402653}
  },
  // Adelaide Street, full of restaurants, bars and hotels.
  "Adelaide Street" : {
    "Adelaide Street / Sherbourne Street": {latitude: 43.652132, longitude: -79.368644},
    "Adelaide Street / Jarvis Street": {latitude: 43.651541, longitude: -79.372367},
    "Adelaide Street / Yonge Street": {latitude: 43.650429, longitude: -79.378433},
    "Adelaide Street / Bay Street": {latitude: 43.649887, longitude: -79.380783},
    "Adelaide Street / University Avenue": {latitude: 43.648870, longitude: -79.385535},
    "Adelaide Street / Simcoe Street": {latitude: 43.648642, longitude: -79.386599},
    "Adelaide Street / Spadina Avenue": {latitude: 43.646751, longitude: -79.395524},
    "Adelaide Street / Bathrust Street": {latitude: 43.645222, longitude: -79.403205}
  },
  // Richmond Street, actual street of Google's Toronto offices
  "Richmond Street" : {
    "Richmond Street / Sherbourne Street": {latitude: 43.653393, longitude: -79.369115},
    "Richmond Street / Jarvis Street": {latitude: 43.652880, longitude: -79.372932},
    "Richmond Street / Yonge Street": {latitude: 43.651721, longitude: -79.378995},
    "Richmond Street / Bay Street": {latitude: 43.651179, longitude: -79.381323},
    "Richmond Street / University Avenue": {latitude: 43.650079, longitude: -79.386261},
    "Richmond Street / Simcoe Street": {latitude: 43.649875, longitude: -79.387150},
    "Richmond Street / Spadina Avenue": {latitude: 43.647852, longitude: -79.396018},
    "Richmond Street / Bathrust Street": {latitude: 43.646464, longitude: -79.403705}
  },
  // Queen Street, facing Nathan-Philipps Square, Toronto's Old City Hall, and the CF Toronto Eaton Centre.
  "Queen Street" : {
    "Queen Street / Sherbourne Street": {latitude: 43.654531, longitude: -79.369460},
    "Queen Street / Jarvis Street": {latitude: 43.653719, longitude: -79.373199},
    "Queen Street / Yonge Street": {latitude: 43.652407, longitude: -79.379287},
    "Queen Street / Bay Street": {latitude: 43.651831, longitude: -79.382132},
    "Queen Street / University Avenue": {latitude: 43.650871, longitude: -79.386613},
    "Queen Street / Simcoe Street": {latitude: 43.650655, longitude: -79.387505},
    "Queen Street / Spadina Avenue": {latitude: 43.648769, longitude: -79.396404},
    "Queen Street / Bathrust Street": {latitude: 43.647191, longitude: -79.404008}
  },
  // Dundas Street, facing Yonge-Dundas Square, Toronto Coach Terminal, and the Art Gallery of Ontario.
  "Dundas Street" : {
    "Dundas Street / Sherbourne Street": {latitude: 43.658290, longitude: -79.370996},
    "Dundas Street / Jarvis Street": {latitude: 43.657038, longitude: -79.374544},
    "Dundas Street / Yonge Street": {latitude: 43.656315, longitude: -79.380911},
    "Dundas Street / Bay Street": {latitude: 43.655747, longitude: -79.383727},
    "Dundas Street / University Avenue": {latitude: 43.654809, longitude: -79.388272},
    "Dundas Street / Simcoe Street": {latitude: 43.654675, longitude: -79.389220},
    "Dundas Street / Spadina Avenue": {latitude: 43.652926, longitude: -79.398003},
    "Dundas Street / Bathrust Street": {latitude: 43.652292, longitude: -79.406013}
  },
  // College / Carlton Street, on the border of the University of Toronto's St. George Campus.
  "College / Carlton Street" : {
    "Carlton Street / Sherbourne Street": {latitude: 43.663184, longitude: -79.373071},
    "Carlton Street / Jarvis Street": {latitude: 43.662404, longitude: -79.376690},
    "College Street / Yonge Street": {latitude: 43.661375, longitude: -79.383099},
    "College Street / Bay Street": {latitude: 43.660819, longitude: -79.385858},
    "College Street / University Avenue": {latitude: 43.659820, longitude: -79.390474},
    "College Street / Spadina Avenue": {latitude: 43.657912, longitude: -79.400016},
    "College Street / Bathrust Street": {latitude: 43.656449, longitude: -79.407718}
  },
};

// Dictionary of some of TTC's subway stations (Line 1) where the user can choose one at their
// convenience. These hold actual coordinates to respect the Google Maps API and the functions
// in the backend that calculate the distance between two points.
const SUBWAY_STATIONS = {
  // Most South station of the line, and central transit hub.
  "Union": {latitude: 43.6452239, longitude: -79.380861},

  // Right side of the U TTC Subway Line 1 makes.
  "King": {latitude: 43.6490598, longitude: -79.3781075},
  "Queen": {latitude: 43.652737, longitude: -79.379616},
  "Dundas": {latitude: 43.6562811, longitude: -79.380459},
  "College": {latitude: 43.6613247, longitude: -79.3830746},
  "Wellesley": {latitude: 43.665653, longitude: -79.383804},
  "Bloor-Yonge": {latitude: 43.6709058, longitude: -79.3856372},

  // Left side of the U TTC Subway Line 1 makes
  "St Andrew": {latitude: 43.6475248, longitude: -79.3844866},
  "Osgoode": {latitude: 43.6506146, longitude: -79.3868315},
  "St Patrick": {latitude: 43.6548307, longitude: -79.3883485},
  "Queen's Park": {latitude: 43.6598804, longitude: -79.3904766},
  "Museum": {latitude: 43.667193, longitude: -79.3935069},
  "St George": {latitude: 43.6682621, longitude: -79.3998583},
  "Spadina TTC": {latitude: 43.6673575, longitude: -79.4038099},
  "Spadina": {latitude: 43.6703608, longitude: -79.4053173},
};

// Dictionary of some of Toronto's attractions where the user can choose one at their
// convenience. These hold actual coordinates to respect the Google Maps API and the functions
// in the backend that calculate the distance between two points.
const LANDMARKS = {
  "CN Tower / Ripley's Aquarium of Canada / Rogers Centre" : {latitude: 43.6425723, longitude: -79.3870772},
  "Air Canada Centre" : {latitude: 43.6434301, longitude: -79.3878058},
  "Yonge-Dundas Square" : {latitude: 43.6560974, longitude: -79.3806114},
  "Nathan-Philipps Square" : {latitude: 43.6522129, longitude: -79.3834585},
  "Union Station" : {latitude: 43.6455067, longitude: -79.3808491},
  "Royal Ontario Museum" : {latitude: 43.6677505, longitude: -79.3946546},
  "Hockey Hall of Fame" : {latitude: 43.6472791, longitude: -79.3777866},
  "Toronto Eaton Centre" : {latitude: 43.6534511, longitude: -79.3806509},
  "Princess of Wales Theatre" : {latitude: 43.6468124, longitude: -79.3891757},
  "Art Gallery of Ontario" : {latitude: 43.6535753, longitude: -79.3925445},
  "Toronto City Hall" : {latitude: 43.6534544, longitude: -79.3840806},
  "Riverdale Farm" : {latitude: 43.6670742, longitude: -79.3612412},
  "Saint Lawrence Market" : {latitude: 43.6485566, longitude: -79.3715872},
  "Harbourfront Centre" : {latitude: 43.6388248, longitude: -79.3819113},
  "Roundhouse Park / Steam Whistle Brewery / The Rec Room" : {latitude: 43.6410088, longitude: -79.3861289},
};

// Creates an object holding reference values and a length to represent the selected preferences the user
// makes in terms of food, drinks, and condiments.
function makeEmptyPreferences() {
  // Insight from https://stackoverflow.com/questions/6622224/jquery-removes-empty-arrays-when-sending
  return {values: [], length: 0};
}

// Creates the head HTML of the content pane that will be displayed when the user clicks on a marker on
// the Google Maps widget in the frontend. A lot of string interpolation is used here to place
// the data the current stand holds in the respective elements and attributes.
function contentStringHead(currentHotDogStand) {
  var contentStringHead = '<div id="content" style="height: 260px; width: 350px;">'+
         '<h4 id="firstHeading" class="firstHeading">' + currentHotDogStand.nameOfStand +
         '</h4>' +
         '<div id="bodyContent">' +
         '<span class="directionsLink" data-hot-dog-stand-index="' + currentHotDogStand.id + '" data-latitude="'
         + currentHotDogStand.latitude +'" data-longitude="' + currentHotDogStand.longitude + '">' +
         'Get directions' +
         '</span>' +
         '<div><b>' +
         'Address: ' + currentHotDogStand.actualAddress +
         '</b></div><div><b>' +
         'Customer Rating: ' + parseFloat(currentHotDogStand.customerRating).toFixed(2) +
         '</b></div>';
  return contentStringHead;
}


// Creates the HTML for all of the available foods of a hot dog stand to be displayed in a
// Google Maps marker info content pane. This is done using a table.
function contentStringForAvailableFoods(standIndex, availableFoodPrices, allFoodInDatabase) {
  // Create the starting content.
  var contentStringForFoods = '<h5>Available Foods: </h5>' +
    '<table>' +
    '<tr><th>Side / Dish</th><th>Price</th></tr>';

  // Cycle through all the available foods the current stand has and write both the name of the
  // food and its corresponding price in a table row.
  for (var foodIndex = 0; foodIndex < availableFoodPrices[standIndex].length; foodIndex++) {
    var currentFoodPriceElement = availableFoodPrices[standIndex][foodIndex];
    contentStringForFoods += '<tr><td>' + allFoodInDatabase[currentFoodPriceElement.food_id - 1].foodName + '</td><td>$' +
      parseFloat(currentFoodPriceElement.price).toFixed(2) + '</td></tr>';
  }

  // End the content with the ending tag.
  contentStringForFoods += '</table>';

  return contentStringForFoods;
}


// Creates the HTML for all of the available drinks of a hot dog stand to be displayed in a
// Google Maps marker info content pane. This is done using a table.
function contentStringForAvailableDrinks(standIndex, availableDrinkPrices, allDrinksInDatabase) {

  // Create the starting content.
  var contentStringForDrinks = '<h5>Available Drinks: </h5>' +
  '<table>' +
  '<tr><th>Drink</th><th>Price</th></tr>';

  // Cycle through all the available drinks the current stand has and write both the name of the
  // drink and its corresponding price in a table row.
  for (var drinkIndex = 0; drinkIndex < availableDrinkPrices[standIndex].length; drinkIndex++) {
    var currentDrinkPriceElement = availableDrinkPrices[standIndex][drinkIndex];
    contentStringForDrinks += '<tr><td>' + allDrinksInDatabase[currentDrinkPriceElement.drink_id - 1].drinkName + '</td><td>$' +
      parseFloat(currentDrinkPriceElement.price).toFixed(2) + '</td></tr>';
  }

  // End the content with the ending tag.
  contentStringForDrinks += '</table>'

  return contentStringForDrinks;
}



// Creates the HTML for all of the available condiments of a hot dog stand to be displayed in a
// Google Maps marker info content pane.
function contentStringForAvailableCondiments(standIndex, availableCondiments, allCondimentsInDatabase) {

  // Create the starting content.
  var contentStringForCondiments = '<h5>Available Condiments: </h5>' +
  '<p>';

  // Loop through all the condiments and append them to the main string that's going to be loaded
  // in the paragraph element in such a way that it's going to make it appear natural.
  var currentCondimentString = '';
  for (var condimentIndex = 0; condimentIndex < availableCondiments[standIndex].length; condimentIndex++) {
    var currentCondimentElement = availableCondiments[standIndex][condimentIndex];

    currentCondimentString = allCondimentsInDatabase[currentCondimentElement.condiment_id - 1].nameOfCondiment;

    if (condimentIndex > 0) // Make the sentence more friendly by lowercasing the condiment string as needed.
      currentCondimentString = currentCondimentString.toLowerCase();

    contentStringForCondiments += currentCondimentString;

    if (condimentIndex < availableCondiments[standIndex].length - 1)
      contentStringForCondiments += ', ';
  }

  // End the content with the ending tag.
  contentStringForCondiments += '</p>';

  return contentStringForCondiments;
}


// Creates the tail HTML of the content pane that will be displayed when the user clicks on a marker
// in the Google Maps widget. This string holds any additional options the hot dog stand can have
// for the customer to choose, such as a type of bun or a spice.
function contentStringTail(currentHotDogStand) {
  var contentStringTail = '';

  // If there are any additional options in the dictionary, create the string for them.
  if (Object.keys(currentHotDogStand.additionalOptions).length != 0) {
    contentStringTail = '<h5>Additional Options: </h5>';

    var additionalOption = '';

    // Loop through all the lists this array holds.
    for (currentKey in currentHotDogStand.additionalOptions) {
      contentStringTail += '<h6>' + currentKey + ':</h6><p>';

      // Loop through all the options that exist in this current array.
      for (var elementIndex = 0; elementIndex < currentHotDogStand.additionalOptions[currentKey].length; elementIndex++) {

        additionalOption = currentHotDogStand.additionalOptions[currentKey][elementIndex];

        if (elementIndex > 0)
          additionalOption = additionalOption.toLowerCase();

        contentStringTail += additionalOption;

        if (elementIndex < currentHotDogStand.additionalOptions[currentKey].length - 1)
          contentStringTail += ', ';
      }

      // Finish off the current array with the ending paragraph tag.
      contentStringTail += '</p>';
    }
  }

  // Complete the content string with the ending div tags.
  contentStringTail += '</div></div>';
  return contentStringTail;
}

// Initializes the Google Maps widget
function initMap(searchResultsData) {

  // Do not create the map data if the search results dictionary does not exist; a safety precaution.
  if (searchResultsData == null)
    return;

  // Create the Google Maps widget using Google's own scripts, and set the center.
  var mapCenter = {lat: 43.642566, lng: -79.387056};
  var map = new google.maps.Map(document.getElementById('map'), {
    zoom: 13,
    center: mapCenter
  });

  // Create a marker and display it on the Google Maps widget to remind the user where they are
  // searching a hot dog stand from.
  var referenceCenter = {lat: searchResultsData.referenceLatitude,
    lng: searchResultsData.referenceLongitude};

  var referenceMarker = new google.maps.Marker({
    position: referenceCenter,
    map: map,
    icon: 'http://maps.google.com/mapfiles/ms/icons/green-dot.png'
  });


  // Display a green circle to indicate the range if the user indicates they want a stand
  // that's within a certain radius from where they are.
  if (searchResultsData.distanceRange != 0) {
    var referenceCircle = new google.maps.Circle({
      strokeColor: '#00DD00',
      strokeOpacity: 0.8,
      strokeWeight: 1,
      fillColor: '#00AA00',
      fillOpacity: 0.3,
      map: map,
      center: referenceCenter,
      radius: searchResultsData.distanceRange
    });
  }

  // Prep the elements for loading and rendering directions on the map widget.
  var directionsService = new google.maps.DirectionsService();
  var directionsDisplay = new google.maps.DirectionsRenderer();

  directionsDisplay.setMap(map);
  directionsDisplay.setPanel(document.getElementById('directionsPanel'));



  var hotDogStandsToDisplay = [];
  var hotDogStandsInformationWindows = [];

  // Loop through all of the stands the search algorithm in the backend has found.
  for (var standIndex = 0; standIndex < searchResultsData.resultingHotDogStands.length; standIndex++) {
    var currentHotDogStand = searchResultsData.resultingHotDogStands[standIndex];
    var standLocation = {lat: parseFloat(currentHotDogStand.latitude), lng: parseFloat(currentHotDogStand.longitude)}

    // Create the corresponding marker on the map to show where the stand is located.
    hotDogStandsToDisplay.push(new google.maps.Marker({
      position: standLocation,
      map: map,
      index: standIndex,
      animation: null
    }));


    // Put together the content that will be displayed in an information window when the user clicks on a marker.
    var contentStringForFoods = contentStringForAvailableFoods(standIndex, searchResultsData.availableFoodPrices,
      searchResultsData.allFood);

    var contentStringForDrinks = contentStringForAvailableDrinks(standIndex, searchResultsData.availableDrinkPrices,
      searchResultsData.allDrinks);

    var contentStringForCondiments = contentStringForAvailableCondiments(standIndex, searchResultsData.availableCondiments,
      searchResultsData.allCondiments);

    var infoWindowContent = contentStringHead(currentHotDogStand) + contentStringForFoods + contentStringForDrinks +
      contentStringForCondiments + contentStringTail(currentHotDogStand);

    // Create the window.
    var newInfoWindow = new google.maps.InfoWindow({
      content: infoWindowContent,
      maxHeight: 300
    });

    hotDogStandsInformationWindows.push(newInfoWindow);


    // Add four listeners to the Google Maps widget to respond to different events for each hot dog stand.
    google.maps.event.addListener(newInfoWindow, 'domready', function(){
      // Load content pane listener.
      loadDirectionListener(directionsService, directionsDisplay, referenceCenter);
    });

    google.maps.event.addListener(hotDogStandsToDisplay[standIndex], 'click', function() {
      // Open the information window on the marker the user has clicked.
      hotDogStandsInformationWindows[this.index].open(map, hotDogStandsToDisplay[this.index]);
    });

    google.maps.event.addListener(hotDogStandsToDisplay[standIndex], 'mouseover', function() {
      // Make the marker bounce when the user hovers the mouse pointer over it.
      hotDogStandsToDisplay[this.index].setAnimation(google.maps.Animation.BOUNCE);
    });

    google.maps.event.addListener(hotDogStandsToDisplay[standIndex], 'mouseout', function() {
      // Stop the bouncing when the user's pointer moves out of the marker.
      hotDogStandsToDisplay[this.index].setAnimation(null);
    });
  }
}



// Loads all the different distance ranges that exist in the metric system.
function loadMetricValues() {
  $.each(METRIC_VALUES, function(key,value) {
    $("#distanceValues").append($("<option></option>")
      .attr("data-value", value).text(key));
  });
}

// Loads all of the major intersections that exist in Toronto's core as options in a combo box.
// (or a dropdown in the terms of Twitter Bootstrap)
function loadMajorIntersections() {
  var $majorIntersections = $("#majorIntersections");
  $.each(MAJOR_INTERSECTIONS, function(key,value) {
    // Organize the list as west-east street groups with their north-south counterparts,
    // giving each group a header to stand out in the frontend for the user's convenience.
    var $optionGroup = $("<optgroup></optgroup>").attr("label", key)
    $majorIntersections.append($optionGroup);
    $.each(value, function(intersection, coordinates) {
      $optionGroup.append($("<option></option>")
        .attr("data-latitude", coordinates.latitude).attr("data-longitude", coordinates.longitude).text(intersection));
    });
  });
}

// Loads the TTC subway stations that exist in Toronto's core as options in a combo box.
// (or a dropdown in the terms of Twitter Bootstrap)
function loadSubwayStations() {
  var $subwayStations = $("#subwayStations");
  $.each(SUBWAY_STATIONS, function(key,value) {
    $subwayStations.append($("<option></option>")
      .attr("data-latitude", value.latitude).attr("data-longitude", value.longitude).text(key));
    });
}

// Loads the landmarks that exist in Toronto's core as options in a combo box.
// (or a dropdown in the terms of Twitter Bootstrap)
function loadLandmarks() {
  var $landmarks = $("#landmarks");
  $.each(LANDMARKS, function(key,value) {
    $landmarks.append($("<option></option>")
      .attr("data-latitude", value.latitude).attr("data-longitude", value.longitude).text(key));
    });
}

// Loads two listeners for the two radio buttons that the user can use to either include a price
// range or not for the individual items. These simply set the 'disabled' attribute of the elements.
function loadRadioButtonListenersForPriceRange() {
  $("#priceRangeSpecified_priceRangeYes").click(function() {
    $("#minimumPrice").prop('disabled', false);
    $("#maximumPrice").prop('disabled', false);
  });

  $("#priceRangeSpecified_priceRangeNo").click(function() {
    $("#minimumPrice").prop('disabled', true);
    $("#maximumPrice").prop('disabled', true);
  });
}


// Loads the listeners for enabling / disabling the different combo boxes (or dropdowns)
// the user has on the interface to select a location they want to find a hot dog stand
// relative to.
function loadRadioButtonListenersForLocationSelection () {
  $("#locationReferenceSelection").change(function() {

    if ($("#locationSelection_majorIntersection").is(':checked'))
      $("#majorIntersections").prop('disabled', false);
    else
      $("#majorIntersections").prop('disabled', true);

    if ($("#locationSelection_subwayStation").is(':checked'))
      $("#subwayStations").prop('disabled', false);
    else
      $("#subwayStations").prop('disabled', true);

    if ($("#locationSelection_landmarks").is(':checked'))
      $("#landmarks").prop('disabled', false);
    else
      $("#landmarks").prop('disabled', true);

    if ($("#locationSelection_latitudeAndLongitude").is(':checked')) {
      $("#latitude").prop('disabled', false);
      $("#longitude").prop('disabled', false);
    } else {
      $("#latitude").prop('disabled', true);
      $("#longitude").prop('disabled', true);
    }
  });
}

// Loads a change listener for the two radio buttons that correspond to the distance unit
// used in the radius the user specifies.
function loadChangeListenerForDistanceUnit() {
  $("input:radio[name=distanceUnit]").change(function() {

    // Empty out all the options that exist in the distanceValues combo box / drop down.
    $("#distanceValues").empty();

    // Then append options for the unit the customer asks for.
    if ($("#distanceUnit_metric").is(':checked'))
      loadMetricValues();
    else
      $.each(IMPERIAL_VALUES, function(key,value) {
        $("#distanceValues").append($("<option></option>")
          .attr("data-value", value).text(key));
        });
  });
}


// Loads the click listener for the submit button the user presses on to send their preferences.
function loadSubmitButtonListener() {
  $("#findHotDogStands").click(function() {



    // Compile the data together into a single dictionary object.
    var searchCriteria = {};

    // Get the user's current position based on their selected option for location.
    if ($("#locationSelection_majorIntersection").is(':checked')) {     // User selected major intersection
      searchCriteria.latitude = $("#majorIntersections option:selected").attr("data-latitude");
      searchCriteria.longitude = $("#majorIntersections option:selected").attr("data-longitude");
    } else if ($("#locationSelection_subwayStation").is(':checked')) {  // User selected subway station
      searchCriteria.latitude = $("#subwayStations option:selected").attr("data-latitude");
      searchCriteria.longitude = $("#subwayStations option:selected").attr("data-longitude");
    } else if ($("#locationSelection_landmarks").is(':checked')) {      // User selected landmarks
      searchCriteria.latitude = $("#landmarks option:selected").attr("data-latitude");
      searchCriteria.longitude = $("#landmarks option:selected").attr("data-longitude");
    } else {                                                            // User selected latitude / longitude
      searchCriteria.latitude = $("#latitude").val();
      searchCriteria.longitude = $("#longitude").val();
    }

    // Get the distance unit the user has asked for, and the range to find a stand that's within.
    if ($("#distanceUnit_metric").is(':checked'))
      searchCriteria.distanceUnit = "KM";
    else
      searchCriteria.distanceUnit = "MI";

    searchCriteria.distanceRange = $("#distanceValues").find('option:selected').attr("data-value");


    // Get the price range the user has specified if they have done so. (This is only applied when)
    // the user selects individual items in the food and drink panes.
    searchCriteria.isAPriceRangeSpecified = $("#priceRangeSpecified_priceRangeYes").is(':checked');

    if (searchCriteria.isAPriceRangeSpecified) {

      var minimumPrice = $("#minimumPrice").val();
      var maximumPrice = $("#maximumPrice").val();

      if (parseFloat(minimumPrice).toFixed(2) > parseFloat(maximumPrice).toFixed(2)) {
        alert("The minimum price is greater than the maximum price. Please fix the error and try again.");
        return;
      }

      searchCriteria.minimumItemPrice = $("#minimumPrice").val();
      searchCriteria.maximumItemPrice = $("#maximumPrice").val();
    }


    // Cycle through all the condiment selections and add them to the foods container.
    searchCriteria.selectedFoods = makeEmptyPreferences();

    $('#food input:checked').each(function() {
      searchCriteria.selectedFoods.values.push($(this).data().foodIndex);
      searchCriteria.selectedFoods.length++;
    });


    // Cycle through all the drink selections and add them to the drinks container.
    searchCriteria.selectedDrinks = makeEmptyPreferences();

    $('#drinks input:checked').each(function() {
      searchCriteria.selectedDrinks.values.push($(this).data().drinkIndex);
      searchCriteria.selectedDrinks.length++;
    });


    // Cycle through all the condiment selections and add them to the condiments container.
    searchCriteria.selectedCondiments = makeEmptyPreferences();

    $('#condiments input:checked').each(function() {
      searchCriteria.selectedCondiments.values.push($(this).data().condimentIndex);
      searchCriteria.selectedCondiments.length++;
    });

    // Let the user know that searching is currently in progress.
    $(this).prop('disabled', true);
    $(this).html("<span class='searchFormHeaders pleaseWaitColor'>Searching; please wait...</span>");


    // Finally, issue a POST request to the server to have it process the search query based on these
    // conditional parameters the user has specified.
    $.ajax({
      method: "POST",
      url: "customers/search",
      headers: {
        // Make this request valid to the server as it's sensitive to cross-site request forgery.
        'X-CSRF-Token': $("#authenticity_token").val()
      },
      data: searchCriteria,           // Set the data content to the search criteria object
      dataType: "json",               // Make the data exchange format as a JSON string.
      success: function(data) {
        // Upon a successful HTTP response, check to see how many resulting stands exist.
        if (data.numberOfResults > 0)
          // If there are resulting stands, load the search results template by a GET request.
          $.get("customers/searchResults", function( renderedHtml ) {
            $("#mainDiv").html(renderedHtml);
            $('[data-toggle="tooltip"]').tooltip({ trigger: "hover" });
            initMap(data);
          });
        else
          // Otherwise, load the 'No Search Results' template by a GET request,
          $.get("customers/noSearchResults", function( renderedHtml ) {
            $("#mainDiv").html(renderedHtml);
          });

          // Scroll to the top of the page.
          $('html,body').scrollTop(0);
      }
    });
  });
}

// Loads a click listener to process directions the Google Maps widget will provide to the
// user on request.
function loadDirectionListener(directionsService, directionsDisplay, startPoint) {
  $(".directionsLink").on('click', function(){



    // Get the hot dog stand's index in finding the coordinates Google Maps will
    // process directions for.
    var hotDogStandIndex = $(this).attr("data-hot-dog-stand-index");


    // Get the travel mode the user is asking for.
    var desiredTravelMode;
    if ($("#travelModeSelection_drivingTravelMode").is(':checked'))
      desiredTravelMode = google.maps.DirectionsTravelMode.DRIVING;
    else if ($("#travelModeSelection_publicTransitTravelMode").is(':checked'))
      desiredTravelMode = google.maps.DirectionsTravelMode.TRANSIT;
    else if ($("#travelModeSelection_bicyclingTravelMode").is(':checked'))
      desiredTravelMode = google.maps.DirectionsTravelMode.BICYCLING;
    else
      desiredTravelMode = google.maps.DirectionsTravelMode.WALKING;


    // Get the unit of distance the user desires from the interface.
    var desiredDistanceUnit;

    if ($("#travelDistanceUnit_metric").is(':checked'))
      desiredDistanceUnit = google.maps.UnitSystem.METRIC;
    else
      desiredDistanceUnit = google.maps.UnitSystem.IMPERIAL;


    // Now put together the directions request object and have the directions service process the
    // request for directions.
    var directionsRequest = {
      origin: new google.maps.LatLng(startPoint.lat, startPoint.lng),
      destination: new google.maps.LatLng($(this).attr("data-latitude"), $(this).attr("data-longitude")),
      travelMode: desiredTravelMode,
      unitSystem: desiredDistanceUnit
    };


    // Let the user know that navigation route and directions are being calculated.
    $("html, body").scrollTop($("#directionsPanel").offset().top);
    $("#directionsPanel").html("<span class='heavyText'>Calculating navigation route and directions... Please wait</span>");

    directionsService.route(directionsRequest, function(response, status) {

      // Upon a response, empty the directions panel and add the appropriate content depending on
      // the status the response holds.
      $("#directionsPanel").html("");

      if (status == google.maps.DirectionsStatus.OK) {
        directionsDisplay.setDirections(response);
      } else {
        $("#directionsPanel").html("Sorry, the directions to this stand are not available. Please try again later.");
      }
    });

  });
}

// Initializes all the listeners by calling the functions that load the independent listeners separately.
function initializeListenersAndValues() {
  loadMetricValues();
  loadMajorIntersections();
  loadSubwayStations();
  loadLandmarks();
  loadRadioButtonListenersForPriceRange();
  loadRadioButtonListenersForLocationSelection ();
  loadChangeListenerForDistanceUnit();
  loadSubmitButtonListener();
  $('[data-toggle="tooltip"]').tooltip({ trigger: "hover" });
}


// Function pre-loading once the full HtML page is ready.
$(function() {

  initializeListenersAndValues();       // Load the listeners.

  // Default click listener for the link that goes back to the search engine.
  $("body").on('click', '#goBackSearchEnginePaneLink', function (){

    // Let the user know that the search pane is being loaded again.
    $("#goBackSearchEnginePaneLink").addClass("text-muted");
    $("#goBackSearchEnginePaneLink").html("Loading, please wait...");
    $("#goBackSearchEnginePaneLink").removeAttr('id');

    $.get("customers/main", function( renderedHtml ) {
      var $replacementElement = $("<output>").append($.parseHTML(renderedHtml)).find("div#mainDiv")[0];
      $("#mainDiv").html($replacementElement.innerHTML);
      initializeListenersAndValues();
    });
  });
})
