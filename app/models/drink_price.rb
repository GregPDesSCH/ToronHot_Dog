=begin
    ToronHot Dog
    Data Models - Hot Dog Stand

    Start Date: March 1, 2018
    End Date:

    File Name: drink_price.rb

    Original Source Code © 2018 Gregory Desrosiers. All rights reserved.
=end

class DrinkPrice < ApplicationRecord
  belongs_to :drink, class_name: Drink, optional: true
  belongs_to :hot_dog_stand, class_name: HotDogStand, optional: true
  validates :price, presence: true                                              # Makes sure the price of the drink is non-null
  # Insight from https://stackoverflow.com/questions/34037823/rails-regexp-validation-for-number-of-decimal-points?rq=1
  validates :price, format: {with: /\A\d+(?:\.\d{0,2})?\z/}, numericality: true # Makes sure the price of the drink is a floating-point value
end
