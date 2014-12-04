class AddPrimaryFromExpressionsHasManifestations < ActiveRecord::Migration
  def change
    add_column :expressions_has_manifestations, :expression_has_manifestation_primary, :integer
  end
end
