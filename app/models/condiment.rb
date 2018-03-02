=begin
    ToronHot Dog
    Data Models - Hot Dog Stand

    Start Date: March 1, 2018
    End Date:

    File Name: condiment.rb

    Original Source Code © 2018 Gregory Desrosiers. All rights reserved.
=end

class Condiment < ApplicationRecord
  self.primary_key = "condiment_id"           # Sets name of primary key column to condiment_id for proper mapping
  belongs_to :HotDogStand                     # One-to-one relationship with the Hot Dog Stand model
  validates :nameOfCondiment, presence: true  # Makes sure the name of the condiment is non-null
end
