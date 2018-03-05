class CreateDrinkPrices < ActiveRecord::Migration[5.1]
  def change
    create_table :drink_prices do |t|
      t.belongs_to :hot_dog_stands, index: true
      t.belongs_to :drink, index: true
      t.decimal :price, :precision => 4, :scale => 2
    end

    
  end
end
