class CreateDrinks < ActiveRecord::Migration[5.1]
  def change
    create_table :drinks do |t|
#      t.belongs_to :hot_dog_stands, index: true
#      t.belongs_to :food_prices, index: true
      t.string :drinkName
    end

    
  end
end
