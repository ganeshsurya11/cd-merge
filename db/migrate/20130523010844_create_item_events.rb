class CreateItemEvents < ActiveRecord::Migration
  def change
    create_table :item_events do |t|
      t.integer :item_id
      t.integer :event_type_id
      t.integer :agent_id
      t.integer :role_id
      t.integer :location_id
      t.string :item_event_start_date
      t.string :item_event_end_date
      t.text :item_event_notes

      t.timestamps
    end
  end
end
