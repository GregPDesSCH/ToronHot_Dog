=begin
    ToronHot Dog
    Data Models - Drink

    Start Date: March 1, 2018
    End Date: March 4, 2018

    File Name: drink.rb

    Original Source Code © 2018 Gregory Desrosiers. All rights reserved.
=end

class Drink < ApplicationRecord
  # Make sure the name of the drink is non-null.
  validates :drinkName, presence: true
end
