class CreateVcItemEvents < ActiveRecord::Migration
  def change
    create_table :vc_item_events do |t|
      t.integer :vc_id
      t.integer :vc_item_id
      t.integer :vc_event_type_id
      t.integer :vc_agent_id
      t.integer :vc_role_id
      t.integer :vc_location_id
      t.integer :vc_Item_event_year
      t.integer :vc_Item_event_month
      t.integer :vc_Item_event_day
      t.integer :vc_user_id
      t.string :vc_user_name
      t.string :vc_user_action
      t.datetime :vc_date_time_stamp

      t.timestamps
    end
  end
end
