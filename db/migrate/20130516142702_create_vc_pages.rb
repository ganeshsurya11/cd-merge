class CreateVcPages < ActiveRecord::Migration
  def change
    create_table :vc_pages do |t|
      t.integer :vc_id
      t.integer :vc_page_page
      t.string :vc_page_image
      t.text :vc_page_notes
      t.integer :vc_user_id
      t.string :vc_user_name
      t.string :vc_user_action
      t.datetime :vc_date_time_stamp

      t.timestamps
    end
  end
end
