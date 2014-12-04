class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :location_name
      t.decimal :location_latitude, :precision => 7, :scale => 4
      t.decimal :location_longitude, :precision => 7, :scale => 4
      t.string :location_ghetty_name
      t.integer :location_ghetty_id
      t.text :location_notes

      t.timestamps
    end
  end
end
