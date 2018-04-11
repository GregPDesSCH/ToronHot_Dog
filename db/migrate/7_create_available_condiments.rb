=begin
  ToronHot Dog
  Database Table and Data Creation - Available Condiments Table

  This migrate file creates the Available Condiments table in a PostgreSQL Database.

  Start Date: March 4, 2018
  End Date: April 10, 2018

  File Name: 7_create_available_condiments.rb

  Original Source Code © 2018 Gregory Desrosiers. All rights reserved.
=end

class CreateAvailableCondiments < ActiveRecord::Migration[5.1]
  def change
    create_table :available_condiments do |t|
      t.belongs_to :hot_dog_stands, index: true
      t.belongs_to :condiment, index: true
    end
  end
end
