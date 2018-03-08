=begin
    ToronHot Dog
    Data Models - Hot Dog Stand

    Start Date: March 5, 2018
    End Date:

    File Name: available_condiment.rb

    Original Source Code © 2018 Gregory Desrosiers. All rights reserved.
=end

class AvailableCondiment < ApplicationRecord
  belongs_to :condiment, class_name: Condiment, optional: true
  belongs_to :hot_dog_stand, class_name: HotDogStand, optional: true
end
