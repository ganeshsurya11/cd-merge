class RemoveAgentIdFromManifestationEvents < ActiveRecord::Migration
  def up
    remove_column :manifestation_events, :agent_id
  end

  def down
    add_column :manifestation_events, :agent_id, :integer
  end
end
