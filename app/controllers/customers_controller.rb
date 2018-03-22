=begin


puts "Metadata for Food: "
puts params["selectedFoods"]
puts params["selectedFoods"]["length"].to_i
puts "\n\n\n"

foodsIndexArray = params["selectedFoods"]["values"].to_a

if params["selectedFoods"]["length"].to_i > 0

  @allSearchResults.each do |currentHotDogStand|
      puts "Searching"
      puts currentHotDogStand.id
      puts FoodPrice.where("hot_dog_stands_id = ?", currentHotDogStand.id)
      puts "Identifying possible stands with foods"
      foodPricesForCurrentStand = FoodPrice.where("hot_dog_stands_id = ?", currentHotDogStand.id)

      foodPricesForCurrentStand.each do |currentFoodPrice|

      end
  end

end





puts "Metadata for Drinks: "
puts params["selectedDrinks"]
puts params["selectedDrinks"]["length"].to_i
puts "\n\n\n"


if params["selectedDrinks"]["length"].to_i > 0
  @allSearchResults.each do |currentHotDogStand|
      puts "Searching"
      puts currentHotDogStand.id
      puts DrinkPrice.where("hot_dog_stands_id = ?", currentHotDogStand.id)
      puts "Identifying possible stands with foods"
      drinkPricesForCurrentStand = DrinkPrice.where("hot_dog_stands_id = ?", currentHotDogStand.id)

      drinkPricesForCurrentStand.each do |currentDrinkPrice|

      end
  end
end





puts "Metadata for Condiments: "
puts params["selectedCondiments"]
puts params["selectedCondiments"]["length"].to_i
puts "\n\n\n"

if params["selectedCondiments"]["length"].to_i > 0
  @allSearchResults.each do |currentHotDogStand|
      puts "Searching"
      puts currentHotDogStand.id
      puts AvailableCondiment.where("hot_dog_stands_id = ?", currentHotDogStand.id)
      puts "Identifying possible stands with foods"
      availableCondimentsForCurrentStand = DrinkPrice.where("hot_dog_stands_id = ?", currentHotDogStand.id)

      availableCondimentsForCurrentStand.each do |currentDrinkPrice|

      end
  end
end

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


  def search
    puts params

    foodPriceQuery = HotDogStand.all
    drinkPriceQuery = HotDogStand.all
    availableCondimentsQuery = HotDogStand.all
    allHotDogStands = HotDogStand.all


    if params["selectedFoods"]["length"].to_i > 0
      params["selectedFoods"]["values"].each do |foodIndex|
        puts "Current food index: " + foodIndex
        #query = query.joins(:food_price).where (id: FoodPrice.where(food_id: foodIndex).exists)

        if params["isAPriceRangeSpecified"] === "true"
          foodPriceQuery = foodPriceQuery.where("exists (select * from food_prices where food_id = ? and " + \
            "food_prices.hot_dog_stands_id = hot_dog_stands.id and food_prices.price >= ? and food_prices.price <= ?)", \
             foodIndex, params["minimumItemPrice"].to_f, params["maximumItemPrice"].to_f)
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



    #puts "Initial drink price query: "
    #puts drinkPriceQuery;
    #puts "Initial available condiments query: "
    #puts availableCondimentsQuery;



    if params["selectedDrinks"]["length"].to_i > 0
      params["selectedDrinks"]["values"].each do |drinkIndex|
        puts "Current drink index: " + drinkIndex
        #query = query.joins(:food_price).where (id: FoodPrice.where(food_id: foodIndex).exists)
        if params["isAPriceRangeSpecified"] === "true"
          drinkPriceQuery = drinkPriceQuery.where("exists (select * from drink_prices where drink_id = ? and " +
            "drink_prices.hot_dog_stands_id = hot_dog_stands.id and drink_prices.price >= ? and drink_prices.price <= ?)", \
            drinkIndex, params["minimumItemPrice"].to_f, params["maximumItemPrice"].to_f)
        else
          drinkPriceQuery = drinkPriceQuery.where("exists (select * from drink_prices where drink_id = ? and " +
            "drink_prices.hot_dog_stands_id = hot_dog_stands.id)", drinkIndex)
        end
        puts "After query buildup"
      end

      #puts drinkPriceQuery
      #drinkPriceQuery.each do |currentStand|
      #  puts currentStand.nameOfStand
      #end
    end


    if params["selectedCondiments"]["length"].to_i > 0
      params["selectedCondiments"]["values"].each do |condimentIndex|
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




    hotDogStandsWithFavourablePositions = []
    if params["distanceUnit"] == "KM" and params["distanceRange"] != "0"
      allHotDogStands.each do |currentHotDogStand|
        #puts "Stand Latitude: " + currentHotDogStand.latitude.to_s
        #puts "Stand Longitude: " + currentHotDogStand.longitude.to_s

        if distanceBetweenTwoPointsLatAndLongInKM(params["latitude"].to_f, params["longitude"].to_f, \
          currentHotDogStand.latitude, currentHotDogStand.longitude) < params["distanceRange"].to_f
          hotDogStandsWithFavourablePositions.push(currentHotDogStand)
        end

      end

    elsif params["distanceUnit"] == "MI" and params["distanceRange"] != "0"

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



    resultingHotDogStands = []

    if hotDogStandsWithFavourablePositions.size > 0

      intermediateHotDogStands1 = []
      intermediateHotDogStands2 = []


      #puts "Before combining searches together for food"
      #puts foodPriceQuery

      if params["selectedFoods"]["length"].to_i > 0

        hotDogStandsWithFavourablePositions.each do |hotDogStandWithinDistance|
          foodPriceQuery.each do |hotDogStandWithSpecifiedFood|
            if hotDogStandWithinDistance.id == hotDogStandWithSpecifiedFood.id
              intermediateHotDogStands1.push(hotDogStandWithSpecifiedFood)
              break
            end
          end
        end

      else
        intermediateHotDogStands1.concat(hotDogStandsWithFavourablePositions)
      end


      #puts "Before combining searches together for drink"
      #puts drinkPriceQuery

      #puts intermediateHotDogStands1
      #puts "\n\n\n"
      if params["selectedDrinks"]["length"].to_i > 0

        intermediateHotDogStands1.each do |currentHotDogStand|
          drinkPriceQuery.each do |hotDogStandWithSpecifiedDrink|
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

      if params["selectedCondiments"]["length"].to_i > 0

        intermediateHotDogStands2.each do |currentHotDogStand|
          availableCondimentsQuery.each do |hotDogStandWithSpecifiedCondiment|
            if currentHotDogStand.id == hotDogStandWithSpecifiedCondiment.id
              resultingHotDogStands.push(hotDogStandWithSpecifiedCondiment)
              break
            end
          end
        end

      else
        resultingHotDogStands.concat(intermediateHotDogStands2)
      end

    end

    #puts "Resulting Stands: "
    #puts resultingHotDogStands

    available_hot_dog_stand_foods = Food.all
    hot_dog_stand_food_prices = FoodPrice.all
    array_of_available_food_prices = []
    array_of_available_drink_prices = []
    array_of_available_condiments = []

    resultingHotDogStands.each do |resultingStand|
    #  puts "Name of Stand: " + resultingStand.nameOfStand
      array_of_available_food_prices.push(FoodPrice.where( "hot_dog_stands_id = ?", resultingStand.id).to_a)
      array_of_available_drink_prices.push(DrinkPrice.where( "hot_dog_stands_id = ?", resultingStand.id).to_a)
      array_of_available_condiments.push(AvailableCondiment.where( "hot_dog_stands_id = ?", resultingStand.id).to_a)
    #  puts array_of_available_food_prices
    end





    # Start looking for hot dog stands that are within a certain distance.

    #@allSearchResults = [];
    #allHotDogStands = HotDogStand.all

    #puts params["distanceUnit"]
    #puts params["distanceRange"]

    # Process the rest of the search query only if there are hot dog stands within the specified distance.
    #if @allSearchResults.length > 0
      # First, check to see if there needs to be any filtering involved on foods, and if yes, do so.
    #end

    #html = render "searchResults"
    #render json: { html: html }

    puts "Rendering view"
    puts resultingHotDogStands.size

    respond_to do |format|
      format.json { render json: { numberOfResults: resultingHotDogStands.size, resultingHotDogStands: resultingHotDogStands, \
        availableFoodPrices: array_of_available_food_prices, allFood: Food.all, \
        availableDrinkPrices: array_of_available_drink_prices, allDrinks: Drink.all, \
        availableCondiments: array_of_available_condiments, allCondiments: Condiment.all } }
    end
  end

  def searchResults
    render :layout => false
  end

  def noSearchResults
    render :layout => false
  end
end
