class AddSurrogateIdToTranscriptions < ActiveRecord::Migration
  def change
    add_column :transcriptions, :surrogate_id, :integer
  end
end
