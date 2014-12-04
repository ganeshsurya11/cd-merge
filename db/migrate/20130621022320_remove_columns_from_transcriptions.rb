class RemoveColumnsFromTranscriptions < ActiveRecord::Migration
  def up
    remove_column :transcriptions, :entity_id
    remove_column :transcriptions, :surrogate_id
  end

  def down
    add_column :transcriptions, :surrogate_id, :integer
    add_column :transcriptions, :entity_id, :integer
  end
end
