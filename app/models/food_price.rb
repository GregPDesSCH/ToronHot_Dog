=begin
    ToronHot Dog
    Data Models - Food Price

    Start Date: March 1, 2018
    End Date: March 4, 2018

    File Name: food_price.rb

    Original Source Code © 2018 Gregory Desrosiers. All rights reserved.
=end

class FoodPrice < ApplicationRecord

  # Ensure a snack / meal is associated with this price, but only add reference when the tables are created successfully.
  belongs_to :food, class_name: Food, optional: true

  # Ensure a hot dog stand is associated with this price, but only add reference when the tables are created successfully.
  belongs_to :hot_dog_stand, class_name: HotDogStand, optional: true

  # Make sure the price of the drink is non-null.
  validates :price, presence: true

  # Make sure the price of the drink is a floating-point value.
  # Insight from https://stackoverflow.com/questions/34037823/rails-regexp-validation-for-number-of-decimal-points?rq=1
  validates :price, format: {with: /\A\d+(?:\.\d{0,2})?\z/}, numericality: true
end
