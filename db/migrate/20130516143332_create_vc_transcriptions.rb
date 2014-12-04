class CreateVcTranscriptions < ActiveRecord::Migration
  def change
    create_table :vc_transcriptions do |t|
      t.integer :vc_id
      t.integer :vc_page_id
      t.integer :vc_item_id
      t.integer :vc_entitiy_id
      t.integer :vc_transcription_order
      t.string :vc_transcription_file
      t.text :vc_transcription_text
      t.text :vc_transcription_tei
      t.text :vc_transcription_notes
      t.integer :vc_user_id
      t.string :vc_user_name
      t.string :vc_user_action
      t.datetime :vc_date_time_stamp

      t.timestamps
    end
  end
end
