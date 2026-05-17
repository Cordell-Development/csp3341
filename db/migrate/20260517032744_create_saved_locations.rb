class CreateSavedLocations < ActiveRecord::Migration[8.1]
  def change
    create_table :saved_locations do |t|
      t.references :user, null: false, foreign_key: true
      t.references :location, null: false, foreign_key: true
      t.boolean :current_location, null: false, default: false

      t.timestamps
    end
    add_index :saved_locations, [:user_id, :location_id], unique: true
    add_index :saved_locations, :user_id, unique: true, where: "current_location = 1", name: "index_saved_locations_on_user_current_location"
  end
end
