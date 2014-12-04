class CreateExpressionsHasManifestations < ActiveRecord::Migration
  def change
    create_table :expressions_has_manifestations do |t|
      t.integer :expression_id
      t.integer :manifestation_id
      t.boolean :expression_has_manifestation_primary

      t.timestamps
    end
  end
end
