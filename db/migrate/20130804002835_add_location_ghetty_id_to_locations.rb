class AddLocationGhettyIdToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :location_ghetty_id, :string
  end
end
