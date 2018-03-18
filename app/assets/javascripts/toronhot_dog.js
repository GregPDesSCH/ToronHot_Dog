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

function initMap() {
  console.log("initMap function has been called.");
  var uluru = {lat: 43.6503521, lng: -79.3837953};
  var mapCenter = {lat: 43.642566, lng: -79.387056};
  var map = new google.maps.Map(document.getElementById('map'), {
    zoom: 12,
    center: mapCenter
  });
  var marker = new google.maps.Marker({
    position: uluru,
    map: map
  });

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
         '</div>';

     var infowindow = new google.maps.InfoWindow({
       content: contentString
     });

     marker2.addListener('click', function() {
         infowindow.open(map, marker2);
     });*/
}

$(function() {

  var $distanceDropdown = $("#distanceValues");
  $.each(METRIC_VALUES, function(key,value) {
    $distanceDropdown.append($("<option></option>")
      .attr("value", value).text(key));
    });

  $("#priceRangeSpecified_priceRangeYes").click(function() {
    $("#minimumPrice").prop('disabled', false);
    $("#maximumPrice").prop('disabled', false);
  });

  $("#priceRangeSpecified_priceRangeNo").click(function() {
    $("#minimumPrice").prop('disabled', true);
    $("#maximumPrice").prop('disabled', true);
  });

  $("#locationReferenceSelection").change(function() {
    if ($("#locationSelection_latitudeAndLongitude").is(':checked')) {
      $("#latitude").prop('disabled', false);
      $("#longitude").prop('disabled', false);
    } else {
      $("#latitude").prop('disabled', true);
      $("#longitude").prop('disabled', true);
    }
  });


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



  $("body").on('click', '#goBackSearchEnginePageLink', function (){
    $.get("customers/main", function( renderedHtml ) {
      $("#mainDiv").html(renderedHtml);
    });
  });


  $("#findHotDogStands").click(function() {

    // Compile the data together
    var searchCriteria = new Object();

    // Position Reference Type
    if ($("#locationSelection_majorIntersection").is(':checked'))
      searchCriteria.positionReferenceType = "MI";
    else if ($("#locationSelection_subwaySection").is(':checked'))
      searchCriteria.positionReferenceType = "SS";
    else if ($("#locationSelection_landmarks").is(':checked'))
      searchCriteria.positionReferenceType = "LM";
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
            initMap();
          });
        else
          $.get("customers/noSearchResults", function( renderedHtml ) {
            $("#mainDiv").html(renderedHtml);
          });



      }
    });
  })
})
