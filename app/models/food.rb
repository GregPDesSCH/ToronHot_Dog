=begin
    ToronHot Dog
    Data Models - Hot Dog Stand

    Start Date: March 1, 2018
    End Date:

    File Name: food.rb

    Original Source Code © 2018 Gregory Desrosiers. All rights reserved.
=end

class Food < ApplicationRecord
  #belongs_to :hot_dog_stands, class_name: HotDogStand                           # One-to-one relationship with the Hot Dog Stand model
  validates :foodName, presence: true                                           # Makes sure the name of the food is non-nulls
end
