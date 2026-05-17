class AddCityNameIndexToLocations < ActiveRecord::Migration[8.1]
  def change
    add_index :locations, :city_name
  end
end
