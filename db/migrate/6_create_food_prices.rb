=begin
  ToronHot Dog
  Database Table and Data Creation - Food Prices Table

  This migrate file creates the Food Prices table in a PostgreSQL Database.

  Start Date: March 4, 2018
  End Date: April 10, 2018

  File Name: 6_create_food_prices.rb

  Original Source Code © 2018 Gregory Desrosiers. All rights reserved.
=end

class CreateFoodPrices < ActiveRecord::Migration[5.1]
  def change
    create_table :food_prices do |t|
      t.belongs_to :hot_dog_stands, index: true
      t.belongs_to :food, index: true
      t.decimal :price, :precision => 4, :scale => 2
    end
  end
end
