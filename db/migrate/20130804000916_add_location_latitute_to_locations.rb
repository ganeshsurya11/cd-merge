class AddLocationLatituteToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :location_latitude, :decimal
  end
end
