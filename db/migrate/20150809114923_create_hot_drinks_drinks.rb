class CreateHotDrinksDrinks < ActiveRecord::Migration
  def change
    create_table :hot_drinks_drinks do |t|
      t.references :machine, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
