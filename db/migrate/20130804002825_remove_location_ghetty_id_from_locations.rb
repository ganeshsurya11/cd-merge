class RemoveLocationGhettyIdFromLocations < ActiveRecord::Migration
  def up
    remove_column :locations, :location_ghetty_id
  end

  def down
    add_column :locations, :location_ghetty_id, :integer
  end
end
