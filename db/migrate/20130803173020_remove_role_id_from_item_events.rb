class RemoveRoleIdFromItemEvents < ActiveRecord::Migration
  def up
    remove_column :item_events, :role_id
  end

  def down
    add_column :item_events, :role_id, :integer
  end
end
