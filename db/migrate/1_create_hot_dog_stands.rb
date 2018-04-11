=begin
  ToronHot Dog
  Database Table and Data Creation - Hot Dog Stand Table

  This migrate file creates the HotDogStand table in a PostgreSQL Database.

  Start Date: March 1, 2018
  End Date: April 10, 2018

  File Name: 1_create_hot_dog_stands.rb

  Original Source Code © 2018 Gregory Desrosiers. All rights reserved.
=end

class CreateHotDogStands < ActiveRecord::Migration[5.1]
  def change
    create_table :hot_dog_stands do |t|
      t.string :nameOfStand
      t.decimal :latitude, :precision=>10, :scale=>6
      t.decimal :longitude, :precision=>10, :scale=>6
      t.decimal :customerRating
      t.text :additionalOptions

      t.string :actualAddress
    end
  end
end
