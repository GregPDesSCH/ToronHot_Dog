class CreateDrinks < ActiveRecord::Migration[5.1]
  def change
    create_table :drinks do |t|

      t.timestamps
    end
  end
end
