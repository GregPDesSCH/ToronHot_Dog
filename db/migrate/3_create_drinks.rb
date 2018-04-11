=begin
  ToronHot Dog
  Database Table and Data Creation - Drinks Table

  This migrate file creates the Drinks table in a PostgreSQL Database.

  Start Date: March 1, 2018
  End Date: April 10, 2018

  File Name: 3_create_drinks.rb

  Original Source Code © 2018 Gregory Desrosiers. All rights reserved.
=end

class CreateDrinks < ActiveRecord::Migration[5.1]
  def change
    create_table :drinks do |t|
      t.string :drinkName
    end
  end
end
