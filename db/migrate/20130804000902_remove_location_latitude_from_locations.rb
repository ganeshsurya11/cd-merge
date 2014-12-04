class RemoveLocationLatitudeFromLocations < ActiveRecord::Migration
  def up
    remove_column :locations, :location_latitude
  end

  def down
    add_column :locations, :location_latitude, :integer
  end
end
