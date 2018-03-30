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

    #@foods.each do |currentItem|
    #  puts currentItem
    #  puts currentItem.id
    #  puts currentItem.foodName
    #end

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

    foodPriceQuery = HotDogStand.all

    if httpRequestParameters["selectedFoods"]["length"].to_i > 0
      httpRequestParameters["selectedFoods"]["values"].each do |foodIndex|
        puts "Current food index: " + foodIndex
        #query = query.joins(:food_price).where (id: FoodPrice.where(food_id: foodIndex).exists)

        if httpRequestParameters["isAPriceRangeSpecified"] === "true"
          foodPriceQuery = foodPriceQuery.where("exists (select * from food_prices where food_id = ? and " + \
            "food_prices.hot_dog_stands_id = hot_dog_stands.id and food_prices.price >= ? and food_prices.price <= ?)", \
             foodIndex, httpRequestParameters["minimumItemPrice"].to_f, httpRequestParameters["maximumItemPrice"].to_f)
        else
          foodPriceQuery = foodPriceQuery.where("exists (select * from food_prices where food_id = ? and " + \
            "food_prices.hot_dog_stands_id = hot_dog_stands.id)", foodIndex)
        end
        puts "After query buildup"
      end

      puts foodPriceQuery
      foodPriceQuery.each do |currentStand|
        puts currentStand.nameOfStand
      end
    end

    return foodPriceQuery
  end




  def filterHotDogStandsByDrinkPreferences(httpRequestParameters)
    drinkPriceQuery = HotDogStand.all

    if httpRequestParameters["selectedDrinks"]["length"].to_i > 0
      httpRequestParameters["selectedDrinks"]["values"].each do |drinkIndex|
        puts "Current drink index: " + drinkIndex
        #query = query.joins(:food_price).where (id: FoodPrice.where(food_id: foodIndex).exists)
        if httpRequestParameters["isAPriceRangeSpecified"] === "true"
          drinkPriceQuery = drinkPriceQuery.where("exists (select * from drink_prices where drink_id = ? and " +
            "drink_prices.hot_dog_stands_id = hot_dog_stands.id and drink_prices.price >= ? and drink_prices.price <= ?)", \
            drinkIndex, httpRequestParameters["minimumItemPrice"].to_f, httpRequestParameters["maximumItemPrice"].to_f)
        else
          drinkPriceQuery = drinkPriceQuery.where("exists (select * from drink_prices where drink_id = ? and " +
            "drink_prices.hot_dog_stands_id = hot_dog_stands.id)", drinkIndex)
        end
        puts "After query buildup"
      end
    end

    return drinkPriceQuery
  end




  def filterHotDogStandsByCondimentPreferences(httpRequestParameters)
    availableCondimentsQuery = HotDogStand.all

    if httpRequestParameters["selectedCondiments"]["length"].to_i > 0
      httpRequestParameters["selectedCondiments"]["values"].each do |condimentIndex|
        puts "Current condiment index: " + condimentIndex
        #query = query.joins(:food_price).where (id: FoodPrice.where(food_id: foodIndex).exists)
        availableCondimentsQuery = availableCondimentsQuery.where("exists (select * from available_condiments where " + \
          " condiment_id = ? and available_condiments.hot_dog_stands_id = hot_dog_stands.id)", condimentIndex)
        puts "After query buildup"
      end

      #puts availableCondimentsQuery
      #availableCondimentsQuery.each do |currentStand|
      #  puts currentStand.nameOfStand
      #end
    end

    return availableCondimentsQuery
  end





  def filterHotDogStandsByDistanceFromReferenceLocation(httpRequestParameters)
    allHotDogStands = HotDogStand.all
    hotDogStandsWithFavourablePositions = []

    if httpRequestParameters["distanceUnit"] == "KM" and httpRequestParameters["distanceRange"] != "0"
      allHotDogStands.each do |currentHotDogStand|
        #puts "Stand Latitude: " + currentHotDogStand.latitude.to_s
        #puts "Stand Longitude: " + currentHotDogStand.longitude.to_s

        if distanceBetweenTwoPointsLatAndLongInKM(httpRequestParameters["latitude"].to_f, httpRequestParameters["longitude"].to_f, \
          currentHotDogStand.latitude, currentHotDogStand.longitude) < httpRequestParameters["distanceRange"].to_f
          hotDogStandsWithFavourablePositions.push(currentHotDogStand)
        end

      end

    elsif httpRequestParameters["distanceUnit"] == "MI" and httpRequestParameters["distanceRange"] != "0"

      allHotDogStands.each do |currentHotDogStand|
        #puts "Stand Latitude: " + currentHotDogStand.latitude.to_s
        #puts "Stand Longitude: " + currentHotDogStand.longitude.to_s

        if distanceBetweenTwoPointsLatAndLongInMI(params["latitude"].to_f, params["longitude"].to_f, \
          currentHotDogStand.latitude, currentHotDogStand.longitude) < params["distanceRange"].to_f
          hotDogStandsWithFavourablePositions.push(currentHotDogStand)
        end

      end

    else
      allHotDogStands.each do |currentHotDogStand|
        hotDogStandsWithFavourablePositions.push(currentHotDogStand)
      end
      #puts "\n\n\n"
      #puts hotDogStandsWithFavourablePositions
      #puts hotDogStandsWithFavourablePositions.size
    end

    return hotDogStandsWithFavourablePositions
  end



  def gatherAllSearchResults(httpRequestParameters)
    resultingHotDogStands = []
    intermediateHotDogStands1 = []
    intermediateHotDogStands2 = []


    #puts "Before combining searches together for food"
    #puts foodPriceQuery

    if httpRequestParameters["selectedFoods"]["length"].to_i > 0

      @hotDogStandsWithFavourablePositions.each do |hotDogStandWithinDistance|
        @foodPriceQuery.each do |hotDogStandWithSpecifiedFood|
          if hotDogStandWithinDistance.id == hotDogStandWithSpecifiedFood.id
            intermediateHotDogStands1.push(hotDogStandWithSpecifiedFood)
            break
          end
        end
      end

    else
      intermediateHotDogStands1.concat(@hotDogStandsWithFavourablePositions)
    end


    #puts "Before combining searches together for drink"
    #puts drinkPriceQuery

    #puts intermediateHotDogStands1
    #puts "\n\n\n"
    if httpRequestParameters["selectedDrinks"]["length"].to_i > 0

      intermediateHotDogStands1.each do |currentHotDogStand|
        @drinkPriceQuery.each do |hotDogStandWithSpecifiedDrink|
          if currentHotDogStand.id == hotDogStandWithSpecifiedDrink.id
            intermediateHotDogStands2.push(hotDogStandWithSpecifiedDrink)
            break
          end
        end
      end

    else
      intermediateHotDogStands2.concat(intermediateHotDogStands1)
    end


    #puts "Before combining searches together for condiments"
    #puts availableCondimentsQuery

    if httpRequestParameters["selectedCondiments"]["length"].to_i > 0

      intermediateHotDogStands2.each do |currentHotDogStand|
        @availableCondimentsQuery.each do |hotDogStandWithSpecifiedCondiment|
          if currentHotDogStand.id == hotDogStandWithSpecifiedCondiment.id
            resultingHotDogStands.push(hotDogStandWithSpecifiedCondiment)
            break
          end
        end
      end

    else
      resultingHotDogStands.concat(intermediateHotDogStands2)
    end

    return resultingHotDogStands
  end



  def gatherAllItemsFromAvailableStands(resultingHotDogStands)
    array_of_available_food_prices = []
    array_of_available_drink_prices = []
    array_of_available_condiments = []

    resultingHotDogStands.each do |resultingStand|
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

    @foodPriceQuery = filterHotDogStandsByFoodPreferences(params)
    @drinkPriceQuery = filterHotDogStandsByDrinkPreferences(params)
    @availableCondimentsQuery = filterHotDogStandsByCondimentPreferences(params)
    @hotDogStandsWithFavourablePositions = filterHotDogStandsByDistanceFromReferenceLocation(params)

    resultingHotDogStands = []

    if @hotDogStandsWithFavourablePositions.size > 0
      resultingHotDogStands = gatherAllSearchResults(params)
    end

    allAvailableItemsForTheStands = gatherAllItemsFromAvailableStands(resultingHotDogStands)


    puts "Rendering view"
    puts resultingHotDogStands.size

    distanceRangeInMeters = 0.00;

    if params["distanceUnit"] == "MI" and params["distanceRange"] != "0"
      distanceRangeInMeters = 1609.34 * params["distanceRange"].to_f
    elsif params["distanceUnit"] == "KM" and params["distanceRange"] != "0"
      distanceRangeInMeters = 1000 * params["distanceRange"].to_f
    end

    respond_to do |format|
      format.json { render json: { referenceLatitude: params["latitude"].to_f, referenceLongitude: params["longitude"].to_f, \
        distanceRange: distanceRangeInMeters, numberOfResults: resultingHotDogStands.size, \
        resultingHotDogStands: resultingHotDogStands, availableFoodPrices: allAvailableItemsForTheStands["availableFoodAndPrices"], \
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
