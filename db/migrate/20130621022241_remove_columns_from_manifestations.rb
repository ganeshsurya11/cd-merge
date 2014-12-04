class RemoveColumnsFromManifestations < ActiveRecord::Migration
  def up
    remove_column :manifestations, :expression_id
  end

  def down
    add_column :manifestations, :expression_id, :integer
  end
end
