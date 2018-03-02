class CreateHotDogStands < ActiveRecord::Migration[5.1]
  def change
    create_table :hot_dog_stands do |t|

      t.timestamps
    end
  end
end
