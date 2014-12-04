class RemovePageIdFromDigitalEditionHasConcordanceEntry < ActiveRecord::Migration
  def up
    remove_column :digital_edition_has_concordance_entries, :page_id
  end

  def down
    add_column :digital_edition_has_concordance_entries, :page_id, :integer
  end
end
