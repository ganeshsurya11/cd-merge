class AddIndexToConcordanceEntries < ActiveRecord::Migration
  def change
    add_index :concordance_entries, :concordance_entry_token
  end
end
