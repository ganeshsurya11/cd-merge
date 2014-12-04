class CreateVcWorks < ActiveRecord::Migration
  def change
    create_table :vc_works do |t|
      t.integer :vc_id
      t.string :vc_work_name
      t.string :vc_work_siglum
      t.integer :vc_work_viaf_id
      t.string :vc_work_viaf_link
      t.text :vc_work_notes
      t.integer :vc_user_id
      t.string :vc_user_name
      t.string :vc_user_action
      t.datetime :vc_date_time_stamp

      t.timestamps
    end
  end
end
