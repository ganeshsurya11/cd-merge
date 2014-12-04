class AddLocationLongituteDecToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :location_longitude, :decimal, {:precision=>10, :scale=>6}
  end
end
