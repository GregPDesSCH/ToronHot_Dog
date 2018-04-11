=begin
  ToronHot Dog
  Database Table and Data Creation - Condiments Table

  This migrate file creates the Condiments table in a PostgreSQL Database.

  Start Date: March 1, 2018
  End Date: April 10, 2018

  File Name: 4_create_condiments.rb

  Original Source Code © 2018 Gregory Desrosiers. All rights reserved.
=end

class CreateCondiments < ActiveRecord::Migration[5.1]
  def change
    create_table :condiments do |t|
      t.string :nameOfCondiment
    end
  end
end
