class CreateAvailableCondiments < ActiveRecord::Migration[5.1]
  def change
    create_table :available_condiments do |t|

      t.timestamps
    end
  end
end
