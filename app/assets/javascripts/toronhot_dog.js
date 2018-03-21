/*
    ToronHot Dog
    Frontend - Application Behavior Code

    Start Date: March 17, 2018
    End Date: March , 2018

    File Name: toronhot_dog.js

    Original Source Code © 2018 Gregory Desrosiers. All rights reserved.
*/
const METRIC_VALUES = {
  "No Range": 0,
  "10 m": 0.01,
  "50 m": 0.05,
  "100 m": 0.1,
  "1/4 km": 0.25,
  "1/2 km": 0.5,
  "1 km": 1,
  "2 km": 2,
  "5 km": 5,
  "10 km": 10
}

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
  "5 mi": 5
};


const MAJOR_INTERSECTIONS = {
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

const SUBWAY_STATIONS = {
  "Union": {latitude: 43.6425723, longitude: -79.3870772},
  "King": {latitude: 43.6425723, longitude: -79.3870772},
  "Queen": {latitude: 43.6425723, longitude: -79.3870772},
  "Dundas": {latitude: 43.6425723, longitude: -79.3870772},
  "College": {latitude: 43.6425723, longitude: -79.3870772},
  "Wellesley": {latitude: 43.6425723, longitude: -79.3870772},
  "Bloor-Yonge": {latitude: 43.6425723, longitude: -79.3870772},
  "St Patrick": {latitude: 43.6425723, longitude: -79.3870772},
  "Queen's Park": {latitude: 43.6425723, longitude: -79.3870772},
  "Museum": {latitude: 43.6425723, longitude: -79.3870772},
};

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

function initMap(searchResultsData) {

  if (searchResultsData == null)
    return

  console.log("initMap function has been called.");
  console.log(searchResultsData);
  var uluru = {lat: 43.6503521, lng: -79.3837953};
  var mapCenter = {lat: 43.642566, lng: -79.387056};
  var map = new google.maps.Map(document.getElementById('map'), {
    zoom: 12,
    center: mapCenter
  });

  var hotDogStandsToDisplay = [];
  var hotDogStandsInformationWindows = [];

  console.log(searchResultsData.resultingHotDogStands);

  for (var index = 0; index < searchResultsData.resultingHotDogStands.length; index++) {
    var currentHotDogStand = searchResultsData.resultingHotDogStands[index];
    console.log(currentHotDogStand);
    var standLocation = {lat: parseFloat(currentHotDogStand.latitude), lng: parseFloat(currentHotDogStand.longitude)}

    hotDogStandsToDisplay.push(new google.maps.Marker({
      position: standLocation,
      map: map,
      index: index
    }));


    var contentStringPart1 = '<div id="content" style="height: 260px; width: 350px;">'+
           '<h1 id="firstHeading" class="firstHeading">' + currentHotDogStand.nameOfStand +
           '</h1>' +
           '<div id="bodyContent">' +
           '<div><b>' +
           'Address: ' + currentHotDogStand.actualAddress +
           '</b></div><div><b>' +
           'Customer Rating: ' + parseFloat(currentHotDogStand.customerRating).toFixed(2) +
           '</b></div>';

    console.log(contentStringPart1);

    var contentStringPart2 = '<h3>Available Foods: </h3>' +
      '<table>' +
      '<tr><th>Side / Dish</th><th>Price</th></tr>';;
    for (var foodIndex = 0; foodIndex < searchResultsData.availableFoodPrices[index].length; foodIndex++) {
      var currentFoodPriceElement = searchResultsData.availableFoodPrices[index][foodIndex];
      contentStringPart2 += '<tr><td>' + searchResultsData.allFood[currentFoodPriceElement.food_id - 1].foodName + '</td><td>$' +
        parseFloat(currentFoodPriceElement.price).toFixed(2) + '</td></tr>';
    }
    contentStringPart2 += '</table>';

    console.log(contentStringPart2);


    var contentStringPart3 = '<h3>Available Drinks: </h3>' +
    '<table>' +
    '<tr><th>Drink</th><th>Price</th></tr>';
    for (var drinkIndex = 0; drinkIndex < searchResultsData.availableDrinkPrices[index].length; drinkIndex++) {
      var currentDrinkPriceElement = searchResultsData.availableDrinkPrices[index][drinkIndex];
      contentStringPart3 += '<tr><td>' + searchResultsData.allDrinks[currentDrinkPriceElement.drink_id - 1].drinkName + '</td><td>$' +
        parseFloat(currentDrinkPriceElement.price).toFixed(2) + '</td></tr>';
    }
    contentStringPart3 += '</table>'

    console.log(contentStringPart3);


    var contentStringPart4 = '<h3>Available Condiments: </h3>' +
    '<p>';
    for (var condimentIndex = 0; condimentIndex < searchResultsData.availableCondiments[index].length; condimentIndex++) {
      var currentCondimentElement = searchResultsData.availableCondiments[index][condimentIndex];
      contentStringPart4 += searchResultsData.allCondiments[currentCondimentElement.condiment_id - 1].nameOfCondiment;

      if (condimentIndex < searchResultsData.availableCondiments[index].length - 1)
        contentStringPart4 += ', ';
    }
    contentStringPart4 += '</p>'

    console.log(contentStringPart4);

    var infoWindowContent = contentStringPart1 + contentStringPart2 + contentStringPart3 + contentStringPart4 +
      '</div></div>'

    /*var contentString = '<div id="content">'+
           '<div id="siteNotice">'+
           '</div>'+
           '<h1 id="firstHeading" class="firstHeading">Meep meep</h1>'+
           '<div id="bodyContent">'+
           '<h3>Available Foods: </h3>' +
           '<table>' +
           '<tr><th>Side / Dish</th><th>Price</th></tr>' +
           '<tr><th>Small french fries</th><th>$2.25</th></tr>' +
           '</table>' +
           '<h3>Available Drinks: </h3>' +
           '<table>' +
           '<tr><th>Drink</th><th>Price</th></tr>' +
           '<tr><td>Dasani Water (750mL)</td><td>$1.25</td></tr>' +
           '</table>' +
           '<h3>Available Condiments: </h3>' +
           '<p>' +
           '</p>' +
           '</div>'+
           '</div>';*/


    hotDogStandsInformationWindows.push(new google.maps.InfoWindow({
      content: infoWindowContent,
      maxHeight: 300
    }));

    google.maps.event.addListener(hotDogStandsToDisplay[index], 'click', function() {
      hotDogStandsInformationWindows[this.index].open(map, hotDogStandsToDisplay[this.index]);
    });
  }
}


function loadMetricValues() {
  var $distanceDropdown = $("#distanceValues");
  $.each(METRIC_VALUES, function(key,value) {
    $distanceDropdown.append($("<option></option>")
      .attr("value", value).text(key));
    });
}

function loadMajorIntersections() {
  var $majorIntersections = $("#majorIntersections");
  $.each(MAJOR_INTERSECTIONS, function(key,value) {
    var $optionGroup = $("<optgroup></optgroup>").attr("label", key)
    $majorIntersections.append($optionGroup);
    $.each(value, function(intersection, coordinates) {
      $optionGroup.append($("<option></option>")
        .attr("data-latitude", coordinates.latitude).attr("data-longitude", coordinates.longitude).text(intersection));
    });
  });
}

function loadSubwayStations() {
  var $subwayStations = $("#subwayStations");
  $.each(SUBWAY_STATIONS, function(key,value) {
    $subwayStations.append($("<option></option>")
      .attr("data-latitude", value.latitude).attr("data-longitude", value.longitude).text(key));
    });
}

function loadLandmarks() {
  var $landmarks = $("#landmarks");
  $.each(LANDMARKS, function(key,value) {
    $landmarks.append($("<option></option>")
      .attr("data-latitude", value.latitude).attr("data-longitude", value.longitude).text(key));
    });
}

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

function loadChangeListenerForDistanceUnit() {
  $("#distanceUnitSelection").change(function() {
    $distanceDropdown.empty();

    if ($("#distanceUnit_metric").is(':checked'))
      $.each(METRIC_VALUES, function(key,value) {
        $distanceDropdown.append($("<option></option>")
          .attr("value", value).text(key));
        });
    else
      $.each(IMPERIAL_VALUES, function(key,value) {
        $distanceDropdown.append($("<option></option>")
          .attr("value", value).text(key));
        });
  });
}



function loadSubmitButtonListener() {
  $("#findHotDogStands").click(function() {

    // Compile the data together
    var searchCriteria = new Object();

    // Position Reference Type
    if ($("#locationSelection_majorIntersection").is(':checked')) {
      searchCriteria.positionReferenceType = "MI";
      searchCriteria.latitude = $("#majorIntersections option:selected").attr("data-latitude");
      searchCriteria.longitude = $("#majorIntersections option:selected").attr("data-longitude");
      //searchCriteria.latitude = $("#majorIntersections");
    }
    else if ($("#locationSelection_subwaySection").is(':checked')) {
      searchCriteria.positionReferenceType = "SS";
      searchCriteria.latitude = $("#subwayStations option:selected").attr("data-latitude");
      searchCriteria.longitude = $("#subwayStations option:selected").attr("data-longitude");
    }
    else if ($("#locationSelection_landmarks").is(':checked')) {
      searchCriteria.positionReferenceType = "LM";
      searchCriteria.latitude = $("#landmarks option:selected").attr("data-latitude");
      searchCriteria.longitude = $("#landmarks option:selected").attr("data-longitude");
    }
    else {
      searchCriteria.positionReferenceType = "LL";
      searchCriteria.latitude = $("#latitude").val();
      searchCriteria.longitude = $("#longitude").val();
    }

    // Distance Range
    if ($("#distanceUnit_metric").is(':checked'))
      searchCriteria.distanceUnit = "KM";
    else
      searchCriteria.distanceUnit = "MI";

    searchCriteria.distanceRange = $("#distanceValues").find('option:selected').val();
    //console.log(searchCriteria.distanceRange);


    // Price Range
    //console.log("Is a price range specified? " + $("#priceRangeSpecified_priceRangeYes").is(':checked'));
    searchCriteria.isAPriceRangeSpecified = $("#priceRangeSpecified_priceRangeYes").is(':checked');
    if ($("#priceRangeSpecified_priceRangeYes").is(':checked')) {
      //console.log("Minimum Price: $" + $("#minimumPrice").val());
      //console.log("Maximum Price: $" + $("#maximumPrice").val());
      searchCriteria.minimumItemPrice = $("#minimumPrice").val();
      searchCriteria.maximumItemPrice = $("#maximumPrice").val();
    }

    /*console.log($("#locationSelection_majorIntersection").is(':checked'));
    console.log($("#locationSelection_subwaySection").is(':checked'));
    console.log($("#locationSelection_landmarks").is(':checked'));
    console.log($("#locationSelection_latitudeAndLongitude").is(':checked'));*/


    // Cycle through all the condiment selections
    // Insight from https://stackoverflow.com/questions/6622224/jquery-removes-empty-arrays-when-sending
    searchCriteria.selectedFoods = {
      values: [],
      length: 0
    };
    //console.log($('#food input:checked'));
    $('#food input:checked').each(function() {
      //console.log($(this).data().foodIndex);
      searchCriteria.selectedFoods.values.push($(this).data().foodIndex);
      searchCriteria.selectedFoods.length++;
    });

    // Cycle through all the drink selections
    searchCriteria.selectedDrinks = {
      values: [],
      length: 0
    };

    //console.log($('#drinks input:checked'));
    $('#drinks input:checked').each(function() {
      //console.log($(this).data().drinkIndex);
      searchCriteria.selectedDrinks.values.push($(this).data().drinkIndex);
      searchCriteria.selectedDrinks.length++;
    });

    // Cycle through all the condiment selections
    searchCriteria.selectedCondiments = {
      values: [],
      length: 0
    };

    //console.log($('#condiments input:checked'));
    $('#condiments input:checked').each(function() {
      //console.log($(this).data().condimentIndex);
      searchCriteria.selectedCondiments.values.push($(this).data().condimentIndex);
      searchCriteria.selectedCondiments.length++;
    });


    $.ajax({
      method: "POST",
      async: false,
      url: "customers/search",
      headers: {
        'X-CSRF-Token': $("#authenticity_token").val()
      },
      data: searchCriteria,
      dataType: "json",
      success: function(data) {
        console.log(data);
        console.log("Number of search results: " + data.numberOfResults);

        if (data.numberOfResults > 0)
          $.get("customers/searchResults", function( renderedHtml ) {
            $("#mainDiv").html(renderedHtml);
            initMap(data);
          });
        else
          $.get("customers/noSearchResults", function( renderedHtml ) {
            $("#mainDiv").html(renderedHtml);
          });
      }
    });
  });
}

function initializeListenersAndValues() {
  loadMetricValues();
  loadMajorIntersections();
  loadSubwayStations();
  loadLandmarks();
  loadRadioButtonListenersForPriceRange();
  loadRadioButtonListenersForLocationSelection ();
  loadChangeListenerForDistanceUnit();
  loadSubmitButtonListener();
}

$(function() {

  initializeListenersAndValues();

  $("body").on('click', '#goBackSearchEnginePageLink', function (){
    $.get("customers/main", function( renderedHtml ) {
      $("#mainDiv").html(renderedHtml);
      initializeListenersAndValues();
    });
  });

})
