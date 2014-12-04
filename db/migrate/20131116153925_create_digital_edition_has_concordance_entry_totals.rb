class CreateDigitalEditionHasConcordanceEntryTotals < ActiveRecord::Migration
  def change
    create_table :digital_edition_has_concordance_entry_totals do |t|
      t.integer :concordance_entry_id
      t.integer :digital_edition_id
      t.integer :entrycount

      t.timestamps
    end
  end
end
