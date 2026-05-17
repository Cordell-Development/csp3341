class CreateApiUsages < ActiveRecord::Migration[8.1]
  def change
    create_table :api_usages do |t|
      t.references :user, foreign_key: true
      t.references :location, foreign_key: true
      t.string :endpoint, null: false
      t.boolean :cache_hit, null: false, default: false

      t.timestamps
    end
  end
end
