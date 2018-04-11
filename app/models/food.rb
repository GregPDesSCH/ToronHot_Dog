=begin
    ToronHot Dog
    Data Models - Food

    This entity data model represents a snack or meal, where it has a name, which
    is a string.

    Start Date: March 1, 2018
    End Date: April 10, 2018

    File Name: food.rb

    Original Source Code © 2018 Gregory Desrosiers. All rights reserved.
=end

class Food < ApplicationRecord
  # Make sure the name of the food is non-null.
  validates :foodName, presence: true
end
