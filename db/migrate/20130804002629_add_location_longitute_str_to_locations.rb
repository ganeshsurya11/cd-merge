class AddLocationLongituteStrToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :location_longitude, :string
  end
end
