=begin
    ToronHot Dog
    Data Models - Condiment

    This entity data model represents a condiment, where it has a name, which
    is a string.

    VERSION 1.0
    Start Date: March 1, 2018
    End Date: March 4, 2018

    File Name: condiment.rb

    Original Source Code © 2018 Gregory Desrosiers. All rights reserved.
=end

class Condiment < ApplicationRecord
  # Makes sure the name of the condiment is non-null.
  validates :nameOfCondiment, presence: true
end
