=begin

  ToronHot Dog
  Main Application Controller

  This is the controller side of the app, which manages the interactions between the views
  and the models. This is where the search algorithm is executed and rendered.

  VERSION 1.0
  Start Date: March 7, 2018
  End Date: April 11, 2018

  File Name: customers_controller.rb

  Original Source Code © 2018 Gregory Desrosiers. All rights reserved.

=end


class CustomersController < ApplicationController

  # This function was used for development purposes, where it loads up all the records that exist
  # in the database to make sure that the data was added properly, and to see how to access the
  # data fields from the frontend.
  #def test
  #  @foods = Food.all
  #  @drinks = Drink.all
  #  @condiments = Condiment.all
  #  @hotDogStands = HotDogStand.all
  #  @foodPrice = FoodPrice.all
  #  @drinkPrice = DrinkPrice.all
  #  @availableCondiments = AvailableCondiment.all
  #end

  # This displays all the foods, drinks, and condiments in the search panel the user sees
  # when they come into the website for the first time.
  def main
    @foods = Food.all
    @drinks = Drink.all
    @condiments = Condiment.all
  end



  # Calculates the distance between two points with latitude and longitude coordinates,
  # using the Haversine formula, in kilometers
  # Code based on https://stackoverflow.com/questions/27928/calculate-distance-between-two-latitude-longitude-points-haversine-formula
  def distanceBetweenTwoPointsLatAndLongInKM(lat1, long1, lat2, long2)
    earthRadius = 6371; # Earth's mean radius in KM
    latitudeChange = (lat2 - lat1) * Math::PI / 180
    longitudeChange = (long2 - long1) * Math::PI / 180
    a = Math.sin(latitudeChange / 2) * Math.sin(latitudeChange / 2) +
      Math.cos(lat1 * Math::PI / 180) * Math.cos(lat2 * Math::PI / 180) *
      Math.sin(longitudeChange / 2) * Math.sin(longitudeChange)
    c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))
    d = earthRadius * c
    return d
  end

  # Does the same thing as above, but converts it to miles.
  def distanceBetweenTwoPointsLatAndLongInMI(lat1, long1, lat2, long2)
    return distanceBetweenTwoPointsLatAndLongInKM(lat1, long1, lat2, long2) * 0.621371;
  end

  # This test function simply outputs the call of the two distance functions above to test them, and renders
  # a Google Maps test page on the frontend.
  #def googleMapsTest
  #  puts distanceBetweenTwoPointsLatAndLongInKM(43.6503521, -79.3837953, 43.686938, -79.399534).to_s + " KM"
  #  puts distanceBetweenTwoPointsLatAndLongInMI(43.6503521, -79.3837953, 43.686938, -79.399534).to_s + " MI"
  #end

  # This adds the preference filters for food by appending the search query, as PostgreSQL, with the call of
  # the exists function from PostgreSQL to check to see if the food exists in the sets of food prices each
  # stand has.
  def filterHotDogStandsByFoodPreferences(httpRequestParameters)
    # Only apply the filters if the user has selected what foods they prefer.
    if httpRequestParameters["selectedFoods"]["length"].to_i > 0
      httpRequestParameters["selectedFoods"]["values"].each do |foodIndex|
        # Upon every preferred food selected, if the user has specified a price range, apply a filter that not only
        # checks to see if the food exists in the set of food prices, but also to see if the food price is within
        # the price range the user has specified. Otherwise, only apply the filter to see if the food exists in
        # the set of food prices.
        if httpRequestParameters["isAPriceRangeSpecified"] === "true"
          @searchQuery = @searchQuery.where("exists (select * from food_prices where food_id = ? and " + \
            "food_prices.hot_dog_stands_id = hot_dog_stands.id and food_prices.price >= ? and food_prices.price <= ?)", \
             foodIndex, httpRequestParameters["minimumItemPrice"].to_f, httpRequestParameters["maximumItemPrice"].to_f)
        else
          @searchQuery = @searchQuery.where("exists (select * from food_prices where food_id = ? and " + \
            "food_prices.hot_dog_stands_id = hot_dog_stands.id)", foodIndex)
        end
      end
    end
  end


  # This adds the preference filters for drinks by appending the search query, as PostgreSQL, with the call of
  # the exists function from PostgreSQL to check to see if the drink exists in the sets of food prices each
  # stand has.
  def filterHotDogStandsByDrinkPreferences(httpRequestParameters)
    # Only apply the filters if the user has selected what drinks they prefer.
    if httpRequestParameters["selectedDrinks"]["length"].to_i > 0
      httpRequestParameters["selectedDrinks"]["values"].each do |drinkIndex|
        # Upon every preferred drink selected, if the user has specified a price range, apply a filter that not only
        # checks to see if the drink exists in the set of drink prices, but also to see if the drink price is within
        # the price range the user has specified. Otherwise, only apply the filter to see if the drink exists in
        # the set of drink prices.
        if httpRequestParameters["isAPriceRangeSpecified"] === "true"
          @searchQuery = @searchQuery.where("exists (select * from drink_prices where drink_id = ? and " +
            "drink_prices.hot_dog_stands_id = hot_dog_stands.id and drink_prices.price >= ? and drink_prices.price <= ?)", \
            drinkIndex, httpRequestParameters["minimumItemPrice"].to_f, httpRequestParameters["maximumItemPrice"].to_f)
        else
          @searchQuery = @searchQuery.where("exists (select * from drink_prices where drink_id = ? and " +
            "drink_prices.hot_dog_stands_id = hot_dog_stands.id)", drinkIndex)
        end
      end
    end
  end

  # This adds the preference filters for condiments by appending the search query, as PostgreSQL, with the call of
  # the exists function from PostgreSQL to check to see if the condiment exists in the set of available condiments
  # for a given stand.
  def filterHotDogStandsByCondimentPreferences(httpRequestParameters)
    # Only apply the filters if the user has selected what drinks they prefer.
    if httpRequestParameters["selectedCondiments"]["length"].to_i > 0
      httpRequestParameters["selectedCondiments"]["values"].each do |condimentIndex|
        # On every preferred condiment selected, append the query with the exists call that checks if that condiment
        # is in the available condiments set.
        @searchQuery = @searchQuery.where("exists (select * from available_condiments where " + \
          " condiment_id = ? and available_condiments.hot_dog_stands_id = hot_dog_stands.id)", condimentIndex)
      end
    end
  end

  # Filters the hot dog stands by checking to see if each of the existing stands from the executed search
  # query so far is within a distance range, if the user has specified one.
  def filterHotDogStandsByDistanceFromReferenceLocation(httpRequestParameters)
    # Use this array to store the stands that will have their data be returned to the frontend for processing.
    hotDogStandsWithFavourablePositions = []

    @searchQuery.each do |currentHotDogStand|
      if httpRequestParameters["distanceUnit"] == "KM" and httpRequestParameters["distanceRange"] != "0"
        # If the user has specified a range in kilometers, check to see that the distance between the user's current position
        # and the hot dog stand is less than the range the user specified in kilometers.
        if distanceBetweenTwoPointsLatAndLongInKM(httpRequestParameters["latitude"].to_f, httpRequestParameters["longitude"].to_f, \
          currentHotDogStand.latitude, currentHotDogStand.longitude) < httpRequestParameters["distanceRange"].to_f
          hotDogStandsWithFavourablePositions.push(currentHotDogStand)
        end
      elsif httpRequestParameters["distanceUnit"] == "MI" and httpRequestParameters["distanceRange"] != "0"
        # If the user has specified a range in miles, check to see that the distance between the user's current position
        # and the hot dog stand is less than the range the user specified in miles.
        if distanceBetweenTwoPointsLatAndLongInKM(httpRequestParameters["latitude"].to_f, httpRequestParameters["longitude"].to_f, \
          currentHotDogStand.latitude, currentHotDogStand.longitude) < httpRequestParameters["distanceRange"].to_f
          hotDogStandsWithFavourablePositions.push(currentHotDogStand)
        end
      else
        # Otherwise, put all of the existing stands into the array.
        hotDogStandsWithFavourablePositions.push(currentHotDogStand)
      end
    end
    return hotDogStandsWithFavourablePositions
  end

  # Pulls all of the items each resulting stand has available (from the Food Prices, Drink Prices and
  # Available Condiments tables) and puts them in an object that will be part of the JSON response.
  def gatherAllItemsFromAvailableStands()

    # Set up three arrays.
    array_of_available_food_prices = []
    array_of_available_drink_prices = []
    array_of_available_condiments = []

    # Get the food prices, drink prices, and available condiments that each stand has.
    @searchQuery.each do |resultingStand|
      array_of_available_food_prices.push(FoodPrice.where( "hot_dog_stands_id = ?", resultingStand.id).to_a)
      array_of_available_drink_prices.push(DrinkPrice.where( "hot_dog_stands_id = ?", resultingStand.id).to_a)
      array_of_available_condiments.push(AvailableCondiment.where( "hot_dog_stands_id = ?", resultingStand.id).to_a)
    end

    # Place the resulting arrays into a hash, a Ruby-based dictionary.
    allAvailableItemsForTheStands = {\
      "availableFoodAndPrices" => array_of_available_food_prices, \
      "availableDrinksAndPrices" => array_of_available_drink_prices, \
      "availableCondiments" => array_of_available_condiments \
    }

    return allAvailableItemsForTheStands
  end

  # This is where all of the search action is performed. In addition to calling the functions above,
  # it preps the response in such a way where the frontend can process it using the data that it's
  # passed back.
  def search

    # Starting query for the search to be performed.
    @searchQuery = HotDogStand.all

    # Add all of the optional filters the user has specified.
    filterHotDogStandsByFoodPreferences(params)
    filterHotDogStandsByDrinkPreferences(params)
    filterHotDogStandsByCondimentPreferences(params)

    # With the resulting stands based on the preferences, filter them down further by distance range.
    hotDogStandsWithFavourablePositions = filterHotDogStandsByDistanceFromReferenceLocation(params)

    # Get all of the data that holds the available items for the resulting stands.
    allAvailableItemsForTheStands = gatherAllItemsFromAvailableStands()


    # Add a distance range return value where the front-end will create a transparent green circle
    # to overlap around the desired area with the user's current location at its center in the
    # Google Maps widget.
    distanceRangeInMeters = 0.00;

    if params["distanceUnit"] == "MI" and params["distanceRange"] != "0"
      distanceRangeInMeters = 1609.34 * params["distanceRange"].to_f
    elsif params["distanceUnit"] == "KM" and params["distanceRange"] != "0"
      distanceRangeInMeters = 1000 * params["distanceRange"].to_f
    end

    # Finally, respond to the AJAX request with a JSON string by putting together the JSON dictionary,
    # then use the gems Ruby on Rails has loaded up to format it into a JSON string.
    respond_to do |format|
      format.json { render json: { referenceLatitude: params["latitude"].to_f, referenceLongitude: params["longitude"].to_f, \
        distanceRange: distanceRangeInMeters, numberOfResults: hotDogStandsWithFavourablePositions.size, \
        resultingHotDogStands: hotDogStandsWithFavourablePositions, availableFoodPrices: allAvailableItemsForTheStands["availableFoodAndPrices"], \
        allFood: Food.all, availableDrinkPrices: allAvailableItemsForTheStands["availableDrinksAndPrices"], allDrinks: Drink.all, \
        availableCondiments: allAvailableItemsForTheStands["availableCondiments"], allCondiments: Condiment.all } }
    end
  end

  # Renders the template that holds the Google Maps widget and additional features if any results
  # have been found in the search. Because we only want the template, the layout is not rendered.
  def searchResults
    render :layout => false
  end

  # Renders the template that holds a text saying no hot dog stands have been found with the
  # search. Because we only want the template, the layout is not rendered.
  def noSearchResults
    render :layout => false
  end
end
