=begin
    ToronHot Dog
    Data Models - Available Condiments

    This relationship model allows hot dog stands to show what condiments they have available.

    VERSION 1.0
    Start Date: March 5, 2018
    End Date: April 10, 2018

    File Name: available_condiment.rb

    Original Source Code © 2018 Gregory Desrosiers. All rights reserved.
=end

class AvailableCondiment < ApplicationRecord

  # These two validators force this model to be a relationship between the
  # condiment and hot dog stand models. Because the foreign key IDs may not be ready
  # by the time "rails db:migrate" is called to create the data, these foreign key
  # ID fields are set to be optional fields.
  belongs_to :condiment, class_name: Condiment, optional: true
  belongs_to :hot_dog_stand, class_name: HotDogStand, optional: true
end
