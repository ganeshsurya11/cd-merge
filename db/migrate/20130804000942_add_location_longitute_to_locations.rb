class AddLocationLongituteToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :location_longitude, :decimal
  end
end
