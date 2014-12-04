class CreateTranscriptions < ActiveRecord::Migration
  def change
    create_table :transcriptions do |t|
      t.integer :page_id
      t.integer :entity_id
      t.integer :transcription_order
      t.string :transcription_file
      t.text :transcription_text
      t.text :transcription_tei
      t.text :transcription_notes

      t.timestamps
    end
  end
end
