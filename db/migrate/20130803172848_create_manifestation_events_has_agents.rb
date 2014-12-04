class CreateManifestationEventsHasAgents < ActiveRecord::Migration
  def change
    create_table :manifestation_events_has_agents do |t|
      t.integer :manifestation_event_id
      t.integer :agent_id
      t.integer :role_id

      t.timestamps
    end
  end
end
