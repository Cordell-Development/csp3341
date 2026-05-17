class CreateLocations < ActiveRecord::Migration[8.1]
  def change
    create_table :locations do |t|
      t.string :city_name, null: false
      t.float :latitude, null: false
      t.float :longitude, null: false
      t.boolean :blacklisted, null: false, default: false

      t.timestamps
    end
    add_index :locations, [ :latitude, :longitude ], unique: true
  end
end
