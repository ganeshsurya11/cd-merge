class CreateVcConcordanceStopWords < ActiveRecord::Migration
  def change
    create_table :vc_concordance_stop_words do |t|
      t.integer :vc_id
      t.string :vc_stop_word_token
      t.integer :vc_user_id
      t.string :vc_user_name
      t.string :vc_user_action
      t.datetime :vc_date_time_stamp

      t.timestamps
    end
  end
end
