class RemovePrimaryFromExpressionsHasManifestations < ActiveRecord::Migration
  def up
    remove_column :expressions_has_manifestations, :expression_has_manifestation_primary
  end

  def down
    add_column :expressions_has_manifestations, :expression_has_manifestation_primary, :boolean
  end
end
