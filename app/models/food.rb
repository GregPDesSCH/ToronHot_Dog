=begin
    ToronHot Dog
    Data Models - Hot Dog Stand

    Start Date: March 1, 2018
    End Date:

    File Name: food.rb

    Original Source Code © 2018 Gregory Desrosiers. All rights reserved.
=end

class Food < ApplicationRecord
  self.primary_key = "food_id"                                                  # Sets name of primary key column to condiment_id for proper mapping
  belongs_to :HotDogStand                                                       # One-to-one relationship with the Hot Dog Stand model
  validates :foodName, presence: true                                           # Makes sure the name of the food is non-null
  validates :price, presence: true                                              # Makes sure the price of the food is non-null
  # Insight from https://stackoverflow.com/questions/34037823/rails-regexp-validation-for-number-of-decimal-points?rq=1
  validates :price, format: {with: /\A\d+(?:\.\d{0,2})?\z/}, numericality: true # Makes sure the price of the food is a floating-point value
end
