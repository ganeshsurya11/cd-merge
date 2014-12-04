class CreateItemEventsHasAgents < ActiveRecord::Migration
  def change
    create_table :item_events_has_agents do |t|
      t.integer :item_event_id
      t.integer :agent_id
      t.integer :role_id

      t.timestamps
    end
  end
end
