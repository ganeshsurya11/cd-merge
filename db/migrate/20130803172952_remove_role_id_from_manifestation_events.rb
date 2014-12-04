class RemoveRoleIdFromManifestationEvents < ActiveRecord::Migration
  def up
    remove_column :manifestation_events, :role_id
  end

  def down
    add_column :manifestation_events, :role_id, :integer
  end
end
