=begin

  ToronHot Dog
  Main Application Controller

  Start Date: March 7, 2018
  End Date: March , 2018

  File Name: customers_controller.rb

  Original Source Code © 2018 Gregory Desrosiers. All rights reserved.

=end



class CustomersController < ApplicationController

  def main
    @foods = Food.all
    @drinks = Drink.all
    @condiments = Condiment.all
  end

  def test
    @foods = Food.all
    @drinks = Drink.all
    @condiments = Condiment.all
    @hotDogStands = HotDogStand.all
    @foodPrice = FoodPrice.all
    @drinkPrice = DrinkPrice.all
    @availableCondiments = AvailableCondiment.all
  end



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

  def distanceBetweenTwoPointsLatAndLongInMI(lat1, long1, lat2, long2)
    return distanceBetweenTwoPointsLatAndLongInKM(lat1, long1, lat2, long2) * 0.621371;
  end

  def googleMapsTest
    puts distanceBetweenTwoPointsLatAndLongInKM(43.6503521, -79.3837953, 43.686938, -79.399534).to_s + " KM"
    puts distanceBetweenTwoPointsLatAndLongInMI(43.6503521, -79.3837953, 43.686938, -79.399534).to_s + " MI"
  end



  def filterHotDogStandsByFoodPreferences(httpRequestParameters)
    if httpRequestParameters["selectedFoods"]["length"].to_i > 0
      httpRequestParameters["selectedFoods"]["values"].each do |foodIndex|
        puts "Current food index: " + foodIndex
        #query = query.joins(:food_price).where (id: FoodPrice.where(food_id: foodIndex).exists)

        if httpRequestParameters["isAPriceRangeSpecified"] === "true"
          @searchQuery = @searchQuery.where("exists (select * from food_prices where food_id = ? and " + \
            "food_prices.hot_dog_stands_id = hot_dog_stands.id and food_prices.price >= ? and food_prices.price <= ?)", \
             foodIndex, httpRequestParameters["minimumItemPrice"].to_f, httpRequestParameters["maximumItemPrice"].to_f)
        else
          @searchQuery = @searchQuery.where("exists (select * from food_prices where food_id = ? and " + \
            "food_prices.hot_dog_stands_id = hot_dog_stands.id)", foodIndex)
        end
        puts "After query buildup"
      end

      puts @searchQuery
      @searchQuery.each do |currentStand|
        puts currentStand.nameOfStand
      end
    end
  end




  def filterHotDogStandsByDrinkPreferences(httpRequestParameters)
    if httpRequestParameters["selectedDrinks"]["length"].to_i > 0
      httpRequestParameters["selectedDrinks"]["values"].each do |drinkIndex|
        puts "Current drink index: " + drinkIndex
        #query = query.joins(:food_price).where (id: FoodPrice.where(food_id: foodIndex).exists)
        if httpRequestParameters["isAPriceRangeSpecified"] === "true"
          @searchQuery = @searchQuery.where("exists (select * from drink_prices where drink_id = ? and " +
            "drink_prices.hot_dog_stands_id = hot_dog_stands.id and drink_prices.price >= ? and drink_prices.price <= ?)", \
            drinkIndex, httpRequestParameters["minimumItemPrice"].to_f, httpRequestParameters["maximumItemPrice"].to_f)
        else
          @searchQuery = @searchQuery.where("exists (select * from drink_prices where drink_id = ? and " +
            "drink_prices.hot_dog_stands_id = hot_dog_stands.id)", drinkIndex)
        end
        puts "After query buildup"
      end
    end
  end




  def filterHotDogStandsByCondimentPreferences(httpRequestParameters)
    if httpRequestParameters["selectedCondiments"]["length"].to_i > 0
      httpRequestParameters["selectedCondiments"]["values"].each do |condimentIndex|
        puts "Current condiment index: " + condimentIndex
        #query = query.joins(:food_price).where (id: FoodPrice.where(food_id: foodIndex).exists)
        @searchQuery = @searchQuery.where("exists (select * from available_condiments where " + \
          " condiment_id = ? and available_condiments.hot_dog_stands_id = hot_dog_stands.id)", condimentIndex)
        puts "After query buildup"
      end
    end
  end





  def filterHotDogStandsByDistanceFromReferenceLocation(httpRequestParameters)
    hotDogStandsWithFavourablePositions = []

    if httpRequestParameters["distanceUnit"] == "KM" and httpRequestParameters["distanceRange"] != "0"
      @searchQuery.each do |currentHotDogStand|
        if distanceBetweenTwoPointsLatAndLongInKM(httpRequestParameters["latitude"].to_f, httpRequestParameters["longitude"].to_f, \
          currentHotDogStand.latitude, currentHotDogStand.longitude) < httpRequestParameters["distanceRange"].to_f
          hotDogStandsWithFavourablePositions.push(currentHotDogStand)
        end

      end

    elsif httpRequestParameters["distanceUnit"] == "MI" and httpRequestParameters["distanceRange"] != "0"
      @searchQuery.each do |currentHotDogStand|
        if distanceBetweenTwoPointsLatAndLongInMI(params["latitude"].to_f, params["longitude"].to_f, \
          currentHotDogStand.latitude, currentHotDogStand.longitude) < params["distanceRange"].to_f
          hotDogStandsWithFavourablePositions.push(currentHotDogStand)
        end

      end

    else
      @searchQuery.each do |currentHotDogStand|
        hotDogStandsWithFavourablePositions.push(currentHotDogStand)
      end
    end

    return hotDogStandsWithFavourablePositions
  end



  def gatherAllItemsFromAvailableStands()
    array_of_available_food_prices = []
    array_of_available_drink_prices = []
    array_of_available_condiments = []

    @searchQuery.each do |resultingStand|
      array_of_available_food_prices.push(FoodPrice.where( "hot_dog_stands_id = ?", resultingStand.id).to_a)
      array_of_available_drink_prices.push(DrinkPrice.where( "hot_dog_stands_id = ?", resultingStand.id).to_a)
      array_of_available_condiments.push(AvailableCondiment.where( "hot_dog_stands_id = ?", resultingStand.id).to_a)
    end

    allAvailableItemsForTheStands = {\
      "availableFoodAndPrices" => array_of_available_food_prices, \
      "availableDrinksAndPrices" => array_of_available_drink_prices, \
      "availableCondiments" => array_of_available_condiments \
    }

    return allAvailableItemsForTheStands
  end




  def search
    puts params

    @searchQuery = HotDogStand.all

    filterHotDogStandsByFoodPreferences(params)
    filterHotDogStandsByDrinkPreferences(params)
    filterHotDogStandsByCondimentPreferences(params)

    #puts "\n\n\n"
    #puts "Full search query::"
    #puts @searchQuery


    #@searchQuery.each do |resultingStand|
    #  puts resultingStand.nameOfStand
    #end

    #puts "\n\n\n"

    hotDogStandsWithFavourablePositions = filterHotDogStandsByDistanceFromReferenceLocation(params)
    #puts hotDogStandsWithFavourablePositions
    #puts hotDogStandsWithFavourablePositions.size

    allAvailableItemsForTheStands = gatherAllItemsFromAvailableStands()


    distanceRangeInMeters = 0.00;

    if params["distanceUnit"] == "MI" and params["distanceRange"] != "0"
      distanceRangeInMeters = 1609.34 * params["distanceRange"].to_f
    elsif params["distanceUnit"] == "KM" and params["distanceRange"] != "0"
      distanceRangeInMeters = 1000 * params["distanceRange"].to_f
    end

    respond_to do |format|
      format.json { render json: { referenceLatitude: params["latitude"].to_f, referenceLongitude: params["longitude"].to_f, \
        distanceRange: distanceRangeInMeters, numberOfResults: hotDogStandsWithFavourablePositions.size, \
        resultingHotDogStands: hotDogStandsWithFavourablePositions, availableFoodPrices: allAvailableItemsForTheStands["availableFoodAndPrices"], \
        allFood: Food.all, availableDrinkPrices: allAvailableItemsForTheStands["availableDrinksAndPrices"], allDrinks: Drink.all, \
        availableCondiments: allAvailableItemsForTheStands["availableCondiments"], allCondiments: Condiment.all } }
    end
  end

  def searchResults
    render :layout => false
  end

  def noSearchResults
    render :layout => false
  end
end
