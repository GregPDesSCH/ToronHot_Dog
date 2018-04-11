=begin
  ToronHot Dog
  Database Table and Data Creation - Foods Table

  This migrate file creates the Foods table in a PostgreSQL Database.

  Start Date: March 1, 2018
  End Date: April 10, 2018

  File Name: 2_create_foods.rb

  Original Source Code © 2018 Gregory Desrosiers. All rights reserved.
=end

class CreateFoods < ActiveRecord::Migration[5.1]
  def change
    create_table :foods do |t|
      t.string :foodName
    end
  end
end
