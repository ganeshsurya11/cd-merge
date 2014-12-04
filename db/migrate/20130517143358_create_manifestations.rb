class CreateManifestations < ActiveRecord::Migration
  def change
    create_table :manifestations do |t|
      t.integer :expression_id
      t.integer :manifestation_type_id
      t.string :manifestation_name
      t.string :manifestation_siglum
      t.string :manifestation_description
      t.text :manifestation_notes

      t.timestamps
    end
  end
end
