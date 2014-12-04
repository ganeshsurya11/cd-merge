class AddLocationLatituteDecToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :location_latitude, :decimal, {:precision=>10, :scale=>6}
  end
end
