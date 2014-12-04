class CreateVcItems < ActiveRecord::Migration
  def change
    create_table :vc_items do |t|
      t.integer :vc_id
      t.integer :vc_manifestation_id
      t.integer :vc_holding_institution_id
      t.string :vc_item_siglum
      t.string :vc_item_description
      t.string :vc_item_shelfmark
      t.text :vc_item_notes
      t.integer :vc_user_id
      t.string :vc_user_name
      t.string :vc_user_action
      t.datetime :vc_date_time_stamp

      t.timestamps
    end
  end
end
