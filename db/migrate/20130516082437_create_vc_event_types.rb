class CreateVcEventTypes < ActiveRecord::Migration
  def change
    create_table :vc_event_types do |t|
      t.integer :vc_id
      t.string :vc_event_type_type
      t.string :vc_event_type_description
      t.text :vc_event_type_notes
      t.integer :vc_user_id
      t.string :vc_user_name
      t.string :vc_user_action
      t.datetime :vc_date_time_stamp

      t.timestamps
    end
  end
end
