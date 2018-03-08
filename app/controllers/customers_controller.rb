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
end
