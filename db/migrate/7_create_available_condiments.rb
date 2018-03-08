class CreateAvailableCondiments < ActiveRecord::Migration[5.1]
  def change
    create_table :available_condiments do |t|
      t.belongs_to :hot_dog_stands, index: true
      t.belongs_to :condiment, index: true
    end
  end
end
