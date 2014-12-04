class CreateConcordanceStopWords < ActiveRecord::Migration
  def change
    create_table :concordance_stop_words do |t|
      t.string :stop_word_token

      t.timestamps
    end
  end
end
