class AddLocationLatituteStrToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :location_latitude, :string
  end
end
