class CreateVcLines < ActiveRecord::Migration
  def change
    create_table :vc_lines do |t|
      t.integer :vc_id
      t.integer :vc_page_id
      t.integer :vc_surrogate_id
      t.integer :vc_entities_id
      t.integer :vc_line_page_order
      t.integer :vc_line_entity_order
      t.string :vc_line_tei
      t.string :vc_line_plaintext
      t.integer :vc_user_id
      t.string :vc_user_name
      t.string :vc_user_action
      t.datetime :vc_date_time_stamp

      t.timestamps
    end
  end
end
