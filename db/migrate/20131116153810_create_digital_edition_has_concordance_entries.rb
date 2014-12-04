class CreateDigitalEditionHasConcordanceEntries < ActiveRecord::Migration
  def change
    create_table :digital_edition_has_concordance_entries do |t|
      t.integer :concordance_entry_id
      t.integer :line_id
      t.integer :page_id
      t.integer :digital_edition_id

      t.timestamps
    end
  end
end
