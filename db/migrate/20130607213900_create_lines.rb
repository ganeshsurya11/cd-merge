class CreateLines < ActiveRecord::Migration
  def change
    create_table :lines do |t|
      t.integer :page_id
      t.integer :surrogate_id
      t.integer :entity_id
      t.integer :transcription_id
      t.integer :line_page_order
      t.integer :line_entity_order
      t.string :line_tei
      t.string :line_plaintext
      t.string :line_variant_version

      t.timestamps
    end
  end
end
