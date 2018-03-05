=begin
    ToronHot Dog
    Data Models - Hot Dog Stand

    Start Date: March 1, 2018
    End Date:

    File Name: hot_dog_stand.rb

    Original Source Code © 2018 Gregory Desrosiers. All rights reserved.
=end

class HotDogStand < ApplicationRecord
  has_many :foods, class_name: Food                           # One-to-many relationship because a hot dog stand has multiple foods the user can choose
  has_many :drinks, class_name: Drink                         # One-to-many relationship because a hot dog stand has multiple drinks the user can choose
  has_many :condiments, class_name: Condiment                 # One-to-many relationship because a hot dog stand has multiple condiments the user can choose
  validates :nameOfStand, presence: true, uniqueness: true    # Makes sure the name of the stand is non-null and is unique.
  validates :latitude, presence: true, numericality: true     # Makes sure the latitude of the stand is non-null, and is a floating-point number
  validates :longitude, presence: true, numericality: true    # Makes sure the longitude of the stand is non-null, and is a floating-point number

  # Makes sure the customer rating of the stand is non-null and is a floating point number, with two decimal places, between 0 and 5.
  validates :customerRating, presence: true, numericality: {greater_than_or_equal_to: 0.00, less_than_or_equal_to: 5.00 },
      format: {with: /\A\d+(?:\.\d{0,2})?\z/}

  serialize :additionalOptions, Hash                          # Upon saving a record of this model, serialize the additional options dictionary
  validate  :hash_is_not_nil                                  # Makes sure the additional options dictionary is non-null
  validates :actualAddress, presence: true                    # Makes sure the actual address is non-null

  def hash_is_not_nil
    self.errors.add :base, 'Hash cannot be nil. It can be empty or filled with some values.' if self.additionalOptions.nil?
  end
end
