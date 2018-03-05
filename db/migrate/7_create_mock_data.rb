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

    hotDogStands[4] = HotDogStand.create! nameOfStand: "The Torontbite", latitude: 43.651406, longitude: -79.379936, \
      customerRating: 5.00, additionalOptions: {}, actualAddress: "27 Richmond Street West"

    hotDogStands[5] = HotDogStand.create! nameOfStand: "Smoky Frankie Franks", latitude: 43.655566, longitude: -79.388870, \
      customerRating: 0.00, additionalOptions: {}, actualAddress: "506 University Avenue"


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
    available_condiment = []
    available_condiment[0] = Condiment.create! nameOfCondiment: "Ketchup"
    available_condiment[1] = Condiment.create! nameOfCondiment: "Mustard"
    available_condiment[2] = Condiment.create! nameOfCondiment: "Relish"
    available_condiment[3] = Condiment.create! nameOfCondiment: "Mayonnaise"
    available_condiment[4] = Condiment.create! nameOfCondiment: "Simulated bacon bits"
    available_condiment[5] = Condiment.create! nameOfCondiment: "Sauerkraut"
    available_condiment[6] = Condiment.create! nameOfCondiment: "White Onions"
    available_condiment[7] = Condiment.create! nameOfCondiment: "Chili"
    available_condiment[8] = Condiment.create! nameOfCondiment: "Coleslaw"
    available_condiment[9] = Condiment.create! nameOfCondiment: "Jalapeño Peppers"
    available_condiment[10] = Condiment.create! nameOfCondiment: "Corn Relish"
    available_condiment[11] = Condiment.create! nameOfCondiment: "Pickled Sweet Peppers"
    available_condiment[12] = Condiment.create! nameOfCondiment: "Hot Sauce"



    DrinkPrice.create! hot_dog_stands_id: hotDogStands[0].id, drink_id: available_drinks[0].id, price: 1.25


    FoodPrice.create! hot_dog_stands_id: hotDogStands[0].id, food_id: available_foods[0].id, price: 2.25


  end
end
