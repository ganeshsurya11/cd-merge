class CreateManifestationEvents < ActiveRecord::Migration
  def change
    create_table :manifestation_events do |t|
      t.integer :manifestation_id
      t.integer :event_type_id
      t.integer :agent_id
      t.integer :role_id
      t.integer :location_id
      t.string :manifestation_event_start_date
      t.string :manifestation_event_end_date
      t.text :manifestation_event_notes

      t.timestamps
    end
  end
end
