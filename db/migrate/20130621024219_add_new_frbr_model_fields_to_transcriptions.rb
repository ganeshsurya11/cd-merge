class AddNewFrbrModelFieldsToTranscriptions < ActiveRecord::Migration
  def change
    add_column :transcriptions, :work_id, :integer
    add_column :transcriptions, :expression_id, :integer
    add_column :transcriptions, :digital_edition_id, :integer
  end
end
