class CreateFeatures < ActiveRecord::Migration[7.1]
  def change
    create_table :features do |t|
      t.string :external_id, null: false
      t.decimal :magnitude, precision: 5, scale: 2, null: false
      t.string :place, null: false
      t.string :mag_type, null: false
      t.string :title, null: false
      t.boolean :tsunami
      t.string :url
      t.float :longitude, null: false
      t.float :latitude, null: false
      t.time :time

      t.timestamps
    end

    add_index :features, :external_id, unique: true
  end
end
