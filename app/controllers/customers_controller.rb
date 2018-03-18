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

  def searchResults
    puts params

    # Start looking for hot dog stands that are within a certain distance.
    @allSearchResults = [];
    allHotDogStands = HotDogStand.all

    puts params["distanceUnit"]
    puts params["distanceRange"]

    if params["distanceUnit"] == "KM" and params["distanceRange"].to_f != 0
      allHotDogStands.each do |currentHotDogStand|
        puts "Stand Latitude: " + currentHotDogStand.latitude.to_s
        puts "Stand Longitude: " + currentHotDogStand.longitude.to_s

        if distanceBetweenTwoPointsLatAndLongInKM(params["latitude"].to_f, params["longitude"].to_f, \
          currentHotDogStand.latitude, currentHotDogStand.longitude) < params["distanceRange"].to_f
          @allSearchResults << currentHotDogStand
        end

      end
      puts "\n\n\n"
      puts @allSearchResults
    end

    # Process the rest of the search query only if there are hot dog stands within the specified distance.
    if @allSearchResults.length > 0
      # First, check to see if there needs to be any filtering involved on foods, and if yes, do so.

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

    end


  end
end
