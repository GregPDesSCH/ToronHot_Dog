=begin
  ToronHot Dog
  Database Table and Data Creation - Drink Prices Table

  This migrate file creates the Drink Prices table in a PostgreSQL Database.

  Start Date: March 4, 2018
  End Date: April 10, 2018

  File Name: 5_create_drink_prices.rb

  Original Source Code © 2018 Gregory Desrosiers. All rights reserved.
=end

class CreateDrinkPrices < ActiveRecord::Migration[5.1]
  def change
    create_table :drink_prices do |t|
      t.belongs_to :hot_dog_stands, index: true
      t.belongs_to :drink, index: true
      t.decimal :price, :precision => 4, :scale => 2
    end
  end
end
