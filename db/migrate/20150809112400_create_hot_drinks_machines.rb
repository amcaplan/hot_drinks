class CreateHotDrinksMachines < ActiveRecord::Migration
  def change
    create_table :hot_drinks_machines do |t|
      t.string :name
      t.references :drink_type, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
