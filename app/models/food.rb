=begin
    ToronHot Dog
    Data Models - Hot Dog Stand

    Start Date: March 1, 2018
    End Date: March 4, 2018

    File Name: food.rb

    Original Source Code © 2018 Gregory Desrosiers. All rights reserved.
=end

class Food < ApplicationRecord
  
  # Make sure the name of the food is non-null.
  validates :foodName, presence: true
end
