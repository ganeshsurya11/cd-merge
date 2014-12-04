class CreateConcordanceEntries < ActiveRecord::Migration
  def change
    create_table :concordance_entries do |t|
      t.string :concordance_entry_token
      t.boolean :concordance_stop
      t.integer :concordance_entry_total

      t.timestamps
    end
  end
end
