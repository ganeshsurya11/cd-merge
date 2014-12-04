class RemoveLocationLongituteFromLocations < ActiveRecord::Migration
  def up
    remove_column :locations, :location_longitude
  end

  def down
    add_column :locations, :location_longitude, :integer
  end
end
