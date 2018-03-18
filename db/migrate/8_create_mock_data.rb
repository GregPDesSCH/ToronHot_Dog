class CreateMockData < ActiveRecord::Migration[5.1]
  def change
    #stand = HotDogStand.new

    #stand.nameOfStand = "Patrick's Big Old Sausages"
    #stand.latitude = 43.656323
    #stand.longitude = -79.40776
    #stand.customerRating = 3.69
    #stand.additionalOptions = { \
    #      "bun" => ["White", "Pretzel", "Garlic", "Multigrain", "Italian"] \
    #  }
    #stand.actualAddress = "479 Bathrust Street"
    #stand.save!

    # Creating all the mock hot dog stands for the project
    hotDogStands = []

    hotDogStands[0] = HotDogStand.create! nameOfStand: "Patrick's Big Old Sausages", latitude: 43.656323, longitude: -79.40776, \
      customerRating: 3.69, additionalOptions: { \
        "bun" => ["White", "Pretzel", "Garlic", "Multigrain", "Italian"] \
      }, actualAddress: "479 Bathrust Street"

    hotDogStands[1] = HotDogStand.create! nameOfStand: "Davio Dave Hot Dogs", latitude: 43.646662, longitude: -79.395636, \
      customerRating: 2.31, additionalOptions: {}, actualAddress: "98 Spadina Avenue"

    hotDogStands[2] = HotDogStand.create! nameOfStand: "Abby and Ally Franks", latitude: 43.642879, longitude: -79.393715, \
      customerRating: 3.90, additionalOptions: {}, actualAddress: "400 Front Street West"

    hotDogStands[3] = HotDogStand.create! nameOfStand: "Billy Jean's Jumbos", latitude: 43.642984, longitude: -79.381632, \
      customerRating: 4.21, additionalOptions: {}, actualAddress: "22 York Street"

    hotDogStands[4] = HotDogStand.create! nameOfStand: "The Torontbite", latitude: 43.655566, longitude: -79.388870, \
      customerRating: 5.00, additionalOptions: {}, actualAddress: "506 University Avenue" # Hot dog stand for SE 464 Scenario 1

    hotDogStands[5] = HotDogStand.create! nameOfStand: "Smoky Frankie Franks", latitude: 43.651406, longitude: -79.379936, \
      customerRating: 0.00, additionalOptions: {}, actualAddress: "27 Richmond Street West"


    # Below are three hot dog stands for SE 464 Scenario 2
    hotDogStands[6] = HotDogStand.create! nameOfStand: "Sighter Dog", latitude: 43.651764, longitude: -79.382791, \
      customerRating: 4.15, additionalOptions: {}, actualAddress: "128 Queen Street West"

    hotDogStands[7] = HotDogStand.create! nameOfStand: "Margaret's Franks", latitude: 43.651743, longitude: -79.382842, \
      customerRating: 4.25, additionalOptions: {}, actualAddress: "128 Queen Street West"

    hotDogStands[8] = HotDogStand.create! nameOfStand: "Tonhouki Hot Dogs", latitude: 43.651721, longitude: -79.382911, \
      customerRating: 4.35, additionalOptions: {}, actualAddress: "128 Queen Street West"


    # Creating all the mock foods for the project
    available_foods = []
    available_foods[0] = Food.create! foodName: "Small french fries"
    available_foods[1] = Food.create! foodName: "Medium french fries"
    available_foods[2] = Food.create! foodName: "Large french fries"

    available_foods[3] = Food.create! foodName: "Small poutines"
    available_foods[4] = Food.create! foodName: "Large poutines"

    available_foods[5] = Food.create! foodName: "Beef Hot Dog"
    available_foods[6] = Food.create! foodName: "Chicken Hot Dog"
    available_foods[7] = Food.create! foodName: "Pork Hot Dog"
    available_foods[8] = Food.create! foodName: "Veggie Hot Dog"
    available_foods[9] = Food.create! foodName: "Halal Hot Dog"

    available_foods[10] = Food.create! foodName: "Beef Jumbo Dog"
    available_foods[11] = Food.create! foodName: "Chicken Jumbo Dog"
    available_foods[12] = Food.create! foodName: "Pork Jumbo Dog"
    available_foods[13] = Food.create! foodName: "Veggie Jumbo Dog"
    available_foods[14] = Food.create! foodName: "Halal Jumbo Dog"

    available_foods[15] = Food.create! foodName: "Beef Sausage"
    available_foods[16] = Food.create! foodName: "Chicken Sausage"
    available_foods[17] = Food.create! foodName: "Pork Sausage"


    # Creating all the mock drinks for the project
    available_drinks = []
    available_drinks[0] = Drink.create! drinkName: "Naya Natural Spring Water (Bottled)"
    available_drinks[1] = Drink.create! drinkName: "DASANI Spring Water (Bottled)"
    available_drinks[2] = Drink.create! drinkName: "PEPSI"
    available_drinks[3] = Drink.create! drinkName: "Coca-Cola"
    available_drinks[4] = Drink.create! drinkName: "7UP"
    available_drinks[5] = Drink.create! drinkName: "Sprite"
    available_drinks[6] = Drink.create! drinkName: "MUG"
    available_drinks[7] = Drink.create! drinkName: "Crush"
    available_drinks[8] = Drink.create! drinkName: "Canada Dry"
    available_drinks[9] = Drink.create! drinkName: "Molson"
    available_drinks[10] = Drink.create! drinkName: "Coors Light"


    # Creating all the mock condiments for the project
    available_condiments = []
    available_condiments[0] = Condiment.create! nameOfCondiment: "Ketchup"
    available_condiments[1] = Condiment.create! nameOfCondiment: "Mustard"
    available_condiments[2] = Condiment.create! nameOfCondiment: "Relish"
    available_condiments[3] = Condiment.create! nameOfCondiment: "Mayonnaise"
    available_condiments[4] = Condiment.create! nameOfCondiment: "Simulated bacon bits"
    available_condiments[5] = Condiment.create! nameOfCondiment: "Sauerkraut"
    available_condiments[6] = Condiment.create! nameOfCondiment: "White Onions"
    available_condiments[7] = Condiment.create! nameOfCondiment: "Chili"
    available_condiments[8] = Condiment.create! nameOfCondiment: "Sour Coleslaw"
    available_condiments[9] = Condiment.create! nameOfCondiment: "Jalapeño Peppers"
    available_condiments[10] = Condiment.create! nameOfCondiment: "Corn Relish"
    available_condiments[11] = Condiment.create! nameOfCondiment: "Pickled Sweet Peppers"
    available_condiments[12] = Condiment.create! nameOfCondiment: "Hot Sauce"
    available_condiments[13] = Condiment.create! nameOfCondiment: "Sour Cream"
    available_condiments[14] = Condiment.create! nameOfCondiment: "Cream Cheese"
    available_condiments[15] = Condiment.create! nameOfCondiment: "Peanut Butter"
    available_condiments[15] = Condiment.create! nameOfCondiment: "Sweet and Sour Sauce"
    available_condiments[16] = Condiment.create! nameOfCondiment: "Barbecue Sauce"
    available_condiments[17] = Condiment.create! nameOfCondiment: "Pasta Sauce"
    available_condiments[18] = Condiment.create! nameOfCondiment: "Salsa"
    available_condiments[19] = Condiment.create! nameOfCondiment: "Guacamole"
    available_condiments[20] = Condiment.create! nameOfCondiment: "Sweet Coleslaw"
    available_condiments[21] = Condiment.create! nameOfCondiment: "Ranch Dressing"
    available_condiments[22] = Condiment.create! nameOfCondiment: "Mozzarella"
    available_condiments[23] = Condiment.create! nameOfCondiment: "Cheddar"
    available_condiments[24] = Condiment.create! nameOfCondiment: "Strawberry Jam"
    available_condiments[25] = Condiment.create! nameOfCondiment: "Orange Jam"
    available_condiments[26] = Condiment.create! nameOfCondiment: "Raspberry Jam"
    available_condiments[27] = Condiment.create! nameOfCondiment: "Dill Pickle"



    ###### Creating all the associations that exist between the stands and the stuff they offer. ######
    ###
    # 1. Patrick's Big Old Sausages
    # customerRating: 3.69
    ###

    # Foods
    FoodPrice.create! hot_dog_stands_id: hotDogStands[0].id, food_id: available_foods[0].id, price: 2.25
    FoodPrice.create! hot_dog_stands_id: hotDogStands[0].id, food_id: available_foods[2].id, price: 4.50
    FoodPrice.create! hot_dog_stands_id: hotDogStands[0].id, food_id: available_foods[3].id, price: 3.00
    FoodPrice.create! hot_dog_stands_id: hotDogStands[0].id, food_id: available_foods[4].id, price: 2.25
    FoodPrice.create! hot_dog_stands_id: hotDogStands[0].id, food_id: available_foods[6].id, price: 2.25
    FoodPrice.create! hot_dog_stands_id: hotDogStands[0].id, food_id: available_foods[7].id, price: 2.25
    FoodPrice.create! hot_dog_stands_id: hotDogStands[0].id, food_id: available_foods[8].id, price: 2.25

    # Drinks
    DrinkPrice.create! hot_dog_stands_id: hotDogStands[0].id, drink_id: available_drinks[0].id, price: 1.25
    DrinkPrice.create! hot_dog_stands_id: hotDogStands[0].id, drink_id: available_drinks[3].id, price: 1.25
    DrinkPrice.create! hot_dog_stands_id: hotDogStands[0].id, drink_id: available_drinks[4].id, price: 1.25
    DrinkPrice.create! hot_dog_stands_id: hotDogStands[0].id, drink_id: available_drinks[6].id, price: 1.25
    DrinkPrice.create! hot_dog_stands_id: hotDogStands[0].id, drink_id: available_drinks[7].id, price: 1.25
    DrinkPrice.create! hot_dog_stands_id: hotDogStands[0].id, drink_id: available_drinks[9].id, price: 1.25

    # Condiments
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[0].id, condiment_id: available_condiments[0].id
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[0].id, condiment_id: available_condiments[3].id
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[0].id, condiment_id: available_condiments[4].id
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[0].id, condiment_id: available_condiments[6].id
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[0].id, condiment_id: available_condiments[8].id
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[0].id, condiment_id: available_condiments[9].id
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[0].id, condiment_id: available_condiments[12].id
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[0].id, condiment_id: available_condiments[18].id








    ###
    # 2. Davio Dave Hot Dogs
    # customerRating: 2.31
    ###

    # Foods
    FoodPrice.create! hot_dog_stands_id: hotDogStands[1].id, food_id: available_foods[0].id, price: 2.25
    FoodPrice.create! hot_dog_stands_id: hotDogStands[1].id, food_id: available_foods[3].id, price: 2.25
    FoodPrice.create! hot_dog_stands_id: hotDogStands[1].id, food_id: available_foods[5].id, price: 2.25
    FoodPrice.create! hot_dog_stands_id: hotDogStands[1].id, food_id: available_foods[7].id, price: 2.25
    FoodPrice.create! hot_dog_stands_id: hotDogStands[1].id, food_id: available_foods[8].id, price: 2.25
    FoodPrice.create! hot_dog_stands_id: hotDogStands[1].id, food_id: available_foods[10].id, price: 2.25
    FoodPrice.create! hot_dog_stands_id: hotDogStands[1].id, food_id: available_foods[12].id, price: 2.25
    FoodPrice.create! hot_dog_stands_id: hotDogStands[1].id, food_id: available_foods[13].id, price: 2.25


    # Drinks
    DrinkPrice.create! hot_dog_stands_id: hotDogStands[1].id, drink_id: available_drinks[0].id, price: 1.25
    DrinkPrice.create! hot_dog_stands_id: hotDogStands[1].id, drink_id: available_drinks[3].id, price: 1.25
    DrinkPrice.create! hot_dog_stands_id: hotDogStands[1].id, drink_id: available_drinks[5].id, price: 1.25
    DrinkPrice.create! hot_dog_stands_id: hotDogStands[1].id, drink_id: available_drinks[6].id, price: 1.25


    # Condiments
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[1].id, condiment_id: available_condiments[0].id
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[1].id, condiment_id: available_condiments[3].id
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[1].id, condiment_id: available_condiments[4].id
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[1].id, condiment_id: available_condiments[5].id
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[1].id, condiment_id: available_condiments[7].id
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[1].id, condiment_id: available_condiments[9].id
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[1].id, condiment_id: available_condiments[16].id








    ###
    # 3. Abby and Ally Franks
    # customerRating: 3.90
    ###

    # Foods
    FoodPrice.create! hot_dog_stands_id: hotDogStands[2].id, food_id: available_foods[0].id, price: 2.25
    FoodPrice.create! hot_dog_stands_id: hotDogStands[2].id, food_id: available_foods[1].id, price: 2.25
    FoodPrice.create! hot_dog_stands_id: hotDogStands[2].id, food_id: available_foods[3].id, price: 2.25
    FoodPrice.create! hot_dog_stands_id: hotDogStands[2].id, food_id: available_foods[4].id, price: 2.25
    FoodPrice.create! hot_dog_stands_id: hotDogStands[2].id, food_id: available_foods[6].id, price: 2.25
    FoodPrice.create! hot_dog_stands_id: hotDogStands[2].id, food_id: available_foods[8].id, price: 2.25
    FoodPrice.create! hot_dog_stands_id: hotDogStands[2].id, food_id: available_foods[9].id, price: 2.25
    FoodPrice.create! hot_dog_stands_id: hotDogStands[2].id, food_id: available_foods[12].id, price: 2.25
    FoodPrice.create! hot_dog_stands_id: hotDogStands[2].id, food_id: available_foods[15].id, price: 2.25


    # Drinks
    DrinkPrice.create! hot_dog_stands_id: hotDogStands[2].id, drink_id: available_drinks[2].id, price: 1.25
    DrinkPrice.create! hot_dog_stands_id: hotDogStands[2].id, drink_id: available_drinks[3].id, price: 1.25
    DrinkPrice.create! hot_dog_stands_id: hotDogStands[2].id, drink_id: available_drinks[5].id, price: 1.25
    DrinkPrice.create! hot_dog_stands_id: hotDogStands[2].id, drink_id: available_drinks[6].id, price: 1.25
    DrinkPrice.create! hot_dog_stands_id: hotDogStands[2].id, drink_id: available_drinks[8].id, price: 1.25
    DrinkPrice.create! hot_dog_stands_id: hotDogStands[2].id, drink_id: available_drinks[9].id, price: 1.25

    # Condiments
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[2].id, condiment_id: available_condiments[0].id
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[2].id, condiment_id: available_condiments[3].id
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[2].id, condiment_id: available_condiments[4].id
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[2].id, condiment_id: available_condiments[6].id
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[2].id, condiment_id: available_condiments[7].id
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[2].id, condiment_id: available_condiments[13].id
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[2].id, condiment_id: available_condiments[14].id
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[2].id, condiment_id: available_condiments[17].id








    ###
    # 4. Billy Jean's Jumbos
    # customerRating: 4.21
    ###

    # Foods
    FoodPrice.create! hot_dog_stands_id: hotDogStands[3].id, food_id: available_foods[0].id, price: 2.25
    FoodPrice.create! hot_dog_stands_id: hotDogStands[3].id, food_id: available_foods[2].id, price: 3.25
    FoodPrice.create! hot_dog_stands_id: hotDogStands[3].id, food_id: available_foods[3].id, price: 4.00
    FoodPrice.create! hot_dog_stands_id: hotDogStands[3].id, food_id: available_foods[4].id, price: 9.25
    FoodPrice.create! hot_dog_stands_id: hotDogStands[3].id, food_id: available_foods[6].id, price: 11.45
    FoodPrice.create! hot_dog_stands_id: hotDogStands[3].id, food_id: available_foods[9].id, price: 13.00
    FoodPrice.create! hot_dog_stands_id: hotDogStands[3].id, food_id: available_foods[12].id, price: 13.00
    FoodPrice.create! hot_dog_stands_id: hotDogStands[3].id, food_id: available_foods[15].id, price: 16.00


    # Drinks
    DrinkPrice.create! hot_dog_stands_id: hotDogStands[3].id, drink_id: available_drinks[0].id, price: 1.25
    DrinkPrice.create! hot_dog_stands_id: hotDogStands[3].id, drink_id: available_drinks[2].id, price: 1.25
    DrinkPrice.create! hot_dog_stands_id: hotDogStands[3].id, drink_id: available_drinks[4].id, price: 1.25
    DrinkPrice.create! hot_dog_stands_id: hotDogStands[3].id, drink_id: available_drinks[5].id, price: 1.25
    DrinkPrice.create! hot_dog_stands_id: hotDogStands[3].id, drink_id: available_drinks[6].id, price: 1.25
    DrinkPrice.create! hot_dog_stands_id: hotDogStands[3].id, drink_id: available_drinks[8].id, price: 1.25
    DrinkPrice.create! hot_dog_stands_id: hotDogStands[3].id, drink_id: available_drinks[9].id, price: 1.25
    DrinkPrice.create! hot_dog_stands_id: hotDogStands[3].id, drink_id: available_drinks[10].id, price: 1.25


    # Condiments
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[3].id, condiment_id: available_condiments[2].id
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[3].id, condiment_id: available_condiments[4].id
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[3].id, condiment_id: available_condiments[6].id
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[3].id, condiment_id: available_condiments[9].id
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[3].id, condiment_id: available_condiments[11].id
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[3].id, condiment_id: available_condiments[14].id
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[3].id, condiment_id: available_condiments[15].id
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[3].id, condiment_id: available_condiments[17].id
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[3].id, condiment_id: available_condiments[18].id
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[3].id, condiment_id: available_condiments[19].id







    ###
    # 5. The Torontbite
    # customerRating: 5.00
    ###

    # Foods
    FoodPrice.create! hot_dog_stands_id: hotDogStands[4].id, food_id: available_foods[0].id, price: 2.25
    FoodPrice.create! hot_dog_stands_id: hotDogStands[4].id, food_id: available_foods[1].id, price: 3.00
    FoodPrice.create! hot_dog_stands_id: hotDogStands[4].id, food_id: available_foods[2].id, price: 3.80
    FoodPrice.create! hot_dog_stands_id: hotDogStands[4].id, food_id: available_foods[3].id, price: 3.50
    FoodPrice.create! hot_dog_stands_id: hotDogStands[4].id, food_id: available_foods[4].id, price: 4.50
    FoodPrice.create! hot_dog_stands_id: hotDogStands[4].id, food_id: available_foods[5].id, price: 3.80
    FoodPrice.create! hot_dog_stands_id: hotDogStands[4].id, food_id: available_foods[6].id, price: 3.80
    FoodPrice.create! hot_dog_stands_id: hotDogStands[4].id, food_id: available_foods[7].id, price: 3.80
    FoodPrice.create! hot_dog_stands_id: hotDogStands[4].id, food_id: available_foods[8].id, price: 3.80
    FoodPrice.create! hot_dog_stands_id: hotDogStands[4].id, food_id: available_foods[9].id, price: 3.80
    FoodPrice.create! hot_dog_stands_id: hotDogStands[4].id, food_id: available_foods[10].id, price: 4.95
    FoodPrice.create! hot_dog_stands_id: hotDogStands[4].id, food_id: available_foods[11].id, price: 4.95
    FoodPrice.create! hot_dog_stands_id: hotDogStands[4].id, food_id: available_foods[12].id, price: 4.95
    FoodPrice.create! hot_dog_stands_id: hotDogStands[4].id, food_id: available_foods[13].id, price: 4.95
    FoodPrice.create! hot_dog_stands_id: hotDogStands[4].id, food_id: available_foods[14].id, price: 4.95
    FoodPrice.create! hot_dog_stands_id: hotDogStands[4].id, food_id: available_foods[15].id, price: 5.95
    FoodPrice.create! hot_dog_stands_id: hotDogStands[4].id, food_id: available_foods[16].id, price: 5.95
    FoodPrice.create! hot_dog_stands_id: hotDogStands[4].id, food_id: available_foods[17].id, price: 5.95



    # Drinks
    DrinkPrice.create! hot_dog_stands_id: hotDogStands[4].id, drink_id: available_drinks[0].id, price: 1.25
    DrinkPrice.create! hot_dog_stands_id: hotDogStands[4].id, drink_id: available_drinks[1].id, price: 1.25
    DrinkPrice.create! hot_dog_stands_id: hotDogStands[4].id, drink_id: available_drinks[2].id, price: 1.25
    DrinkPrice.create! hot_dog_stands_id: hotDogStands[4].id, drink_id: available_drinks[3].id, price: 1.25
    DrinkPrice.create! hot_dog_stands_id: hotDogStands[4].id, drink_id: available_drinks[4].id, price: 1.25
    DrinkPrice.create! hot_dog_stands_id: hotDogStands[4].id, drink_id: available_drinks[5].id, price: 1.25
    DrinkPrice.create! hot_dog_stands_id: hotDogStands[4].id, drink_id: available_drinks[6].id, price: 1.25
    DrinkPrice.create! hot_dog_stands_id: hotDogStands[4].id, drink_id: available_drinks[7].id, price: 1.25
    DrinkPrice.create! hot_dog_stands_id: hotDogStands[4].id, drink_id: available_drinks[8].id, price: 1.25
    DrinkPrice.create! hot_dog_stands_id: hotDogStands[4].id, drink_id: available_drinks[9].id, price: 1.25
    DrinkPrice.create! hot_dog_stands_id: hotDogStands[4].id, drink_id: available_drinks[10].id, price: 1.25


    # Condiments
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[4].id, condiment_id: available_condiments[0].id
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[4].id, condiment_id: available_condiments[1].id
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[4].id, condiment_id: available_condiments[2].id
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[4].id, condiment_id: available_condiments[3].id
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[4].id, condiment_id: available_condiments[4].id
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[4].id, condiment_id: available_condiments[5].id
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[4].id, condiment_id: available_condiments[6].id
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[4].id, condiment_id: available_condiments[7].id
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[4].id, condiment_id: available_condiments[8].id
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[4].id, condiment_id: available_condiments[9].id
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[4].id, condiment_id: available_condiments[10].id
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[4].id, condiment_id: available_condiments[11].id
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[4].id, condiment_id: available_condiments[12].id
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[4].id, condiment_id: available_condiments[13].id
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[4].id, condiment_id: available_condiments[14].id
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[4].id, condiment_id: available_condiments[15].id
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[4].id, condiment_id: available_condiments[16].id
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[4].id, condiment_id: available_condiments[17].id
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[4].id, condiment_id: available_condiments[18].id
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[4].id, condiment_id: available_condiments[19].id
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[4].id, condiment_id: available_condiments[20].id
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[4].id, condiment_id: available_condiments[21].id
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[4].id, condiment_id: available_condiments[22].id
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[4].id, condiment_id: available_condiments[23].id
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[4].id, condiment_id: available_condiments[27].id








    ###
    # 6. Smoky Frankie Franks
    ###

    # Foods
    FoodPrice.create! hot_dog_stands_id: hotDogStands[5].id, food_id: available_foods[0].id, price: 10.00

    # Drinks
    DrinkPrice.create! hot_dog_stands_id: hotDogStands[5].id, drink_id: available_drinks[1].id, price: 5.00

    # Condiments
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[5].id, condiment_id: available_condiments[24].id
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[5].id, condiment_id: available_condiments[25].id
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[5].id, condiment_id: available_condiments[26].id







    ###
    # 7. Sighter Dog
    ###
    # Foods
    FoodPrice.create! hot_dog_stands_id: hotDogStands[6].id, food_id: available_foods[8].id, price: 4.00

    # Drinks
    DrinkPrice.create! hot_dog_stands_id: hotDogStands[6].id, drink_id: available_drinks[0].id, price: 2.00

    # Condiments
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[6].id, condiment_id: available_condiments[0].id






    ###
    # 8. Margaret's Franks
    ###
    # Foods
    FoodPrice.create! hot_dog_stands_id: hotDogStands[7].id, food_id: available_foods[8].id, price: 4.00

    # Drinks
    DrinkPrice.create! hot_dog_stands_id: hotDogStands[7].id, drink_id: available_drinks[0].id, price: 2.00

    # Condiments
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[7].id, condiment_id: available_condiments[0].id







    ###
    # 9. Tonhouki Hot Dogs
    ###
    # Foods
    FoodPrice.create! hot_dog_stands_id: hotDogStands[8].id, food_id: available_foods[8].id, price: 4.00

    # Drinks
    DrinkPrice.create! hot_dog_stands_id: hotDogStands[8].id, drink_id: available_drinks[0].id, price: 1.25

    # Condiments
    AvailableCondiment.create! hot_dog_stands_id: hotDogStands[8].id, condiment_id: available_condiments[0].id

  end
end
