class CreateVcLocations < ActiveRecord::Migration
  def change
    create_table :vc_locations do |t|
      t.integer :vc_id
      t.string :vc_location_name
      t.decimal :vc_location_latitude
      t.decimal :vc_location_longitude
      t.string :vc_location_ghetty_name
      t.integer :vc_location_ghetty_id
      t.integer :vc_user_id
      t.string :vc_user_name
      t.string :vc_user_action
      t.datetime :vc_date_time_stamp

      t.timestamps
    end
  end
end
