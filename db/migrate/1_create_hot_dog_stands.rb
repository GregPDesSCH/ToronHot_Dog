class CreateHotDogStands < ActiveRecord::Migration[5.1]
  def change
    create_table :hot_dog_stands do |t|
      t.string :nameOfStand
      t.decimal :latitude, :precision=>10, :scale=>6
      t.decimal :longitude, :precision=>10, :scale=>6
      t.decimal :customerRating
      #t.has_many :food
      #t.has_many :drink
      #t.has_many :condiment
      t.text :additionalOptions

      t.string :actualAddress
    end

    

  end
end
