class CreateEditionTeis < ActiveRecord::Migration
  def change
    create_table :edition_teis do |t|
      t.integer :digital_edition_id
      t.text :tei_build_tei

      t.timestamps
    end
  end
end
