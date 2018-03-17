/*
    ToronHot Dog
    Frontend - Application Behavior Code

    Start Date: March 1, 2018
    End Date: March 4, 2018

    File Name: toronhot_dog.rb

    Original Source Code © 2018 Gregory Desrosiers. All rights reserved.
*/
const METRIC_VALUES = {
  "No Range": Number.POSITIVE_INFINITY,
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
  "No Range": Number.POSITIVE_INFINITY,
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
    //if ($("#distanceUnit_metric").is(':checked'


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
    searchCriteria.selectedFoods = [];
    //console.log($('#food input:checked'));
    $('#food input:checked').each(function() {
      //console.log($(this).data().foodIndex);
      searchCriteria.selectedFoods.push($(this).data().foodIndex);
    });

    // Cycle through all the drink selections
    searchCriteria.selectedDrinks = [];
    //console.log($('#drinks input:checked'));
    $('#drinks input:checked').each(function() {
      //console.log($(this).data().drinkIndex);
      searchCriteria.selectedDrinks.push($(this).data().drinkIndex);
    });

    // Cycle through all the condiment selections
    searchCriteria.selectedCondiments = [];
    //console.log($('#condiments input:checked'));
    $('#condiments input:checked').each(function() {
      //console.log($(this).data().condimentIndex);
      searchCriteria.selectedCondiments.push($(this).data().condimentIndex);
    });


    $.ajax({
      method: "POST",
      url: "customers/searchResults",
      headers: {
        'X-CSRF-Token': $("#authenticity_token").val()
      },
      data: searchCriteria,
      dataType: "json"
    });
  })
})
