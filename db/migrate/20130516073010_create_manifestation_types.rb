class CreateManifestationTypes < ActiveRecord::Migration
  def change
    create_table :manifestation_types do |t|
      t.string :manifestation_type_type
      t.string :manifestation_type_description
      t.text :manifestation_type_notes

      t.timestamps
    end
  end
end
