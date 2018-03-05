class CreateCondiments < ActiveRecord::Migration[5.1]
  def change
    create_table :condiments do |t|
#      t.belongs_to :hot_dog_stands, index: true
      t.string :nameOfCondiment
    end


  end
end
