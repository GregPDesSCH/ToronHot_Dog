=begin
    ToronHot Dog
    Data Models - Hot Dog Stand

    Start Date: March 1, 2018
    End Date: March 4, 2018

    File Name: hot_dog_stand.rb

    Original Source Code © 2018 Gregory Desrosiers. All rights reserved.
=end

class HotDogStand < ApplicationRecord

  # One-to-many relationship because a hot dog stand has multiple foods the user can choose.
  has_many :foods, class_name: Food

  has_many :food_price, class_name: FoodPrice

  # One-to-many relationship because a hot dog stand has multiple drinks the user can choose.
  has_many :drinks, class_name: Drink

  # One-to-many relationship because a hot dog stand has multiple condiments the user can choose.
  has_many :condiments, class_name: Condiment

  # Make sure the name of the stand is non-null and is unique.
  validates :nameOfStand, presence: true, uniqueness: true

  # Make sure the latitude of the stand is non-null, and is a floating-point number.
  validates :latitude, presence: true, numericality: true

  # Make sure the longitude of the stand is non-null, and is a floating-point number.
  validates :longitude, presence: true, numericality: true

  # Make sure the customer rating of the stand is non-null and is a floating point number, with two decimal places, between 0 and 5.
  validates :customerRating, presence: true, numericality: {greater_than_or_equal_to: 0.00, less_than_or_equal_to: 5.00 },
      format: {with: /\A\d+(?:\.\d{0,2})?\z/}

  # Upon saving a record of this model, serialize the additional options dictionary
  serialize :additionalOptions, Hash

  # Make sure the additional options dictionary is non-null by using a custom validator.
  validate  :hash_is_not_nil

  # Make sure the actual address is non-null
  validates :actualAddress, presence: true

  # Custom validator to make sure that the hash reference is not null; if yes, it throws an error with a custom message.
  def hash_is_not_nil
    self.errors.add :base, 'Hash cannot be nil. It can be empty or filled with some values.' if self.additionalOptions.nil?
  end
end
