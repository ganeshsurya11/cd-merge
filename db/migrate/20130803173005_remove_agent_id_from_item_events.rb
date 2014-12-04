class RemoveAgentIdFromItemEvents < ActiveRecord::Migration
  def up
    remove_column :item_events, :agent_id
  end

  def down
    add_column :item_events, :agent_id, :integer
  end
end
