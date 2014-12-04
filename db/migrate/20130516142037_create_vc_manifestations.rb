class CreateVcManifestations < ActiveRecord::Migration
  def change
    create_table :vc_manifestations do |t|
      t.integer :vc_id
      t.integer :vc_expression_id
      t.integer :vc_manifestation_type_id
      t.string :vc_manifestation_title
      t.string :vc_manifestation_siglum
      t.string :vc_manifestation_description
      t.text :vc_manifestation_notes
      t.integer :vc_user_id
      t.string :vc_user_name
      t.string :vc_user_action
      t.datetime :vc_date_time_stamp

      t.timestamps
    end
  end
end
