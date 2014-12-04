class CreateVcEntities < ActiveRecord::Migration
  def change
    create_table :vc_entities do |t|
      t.integer :vc_id
      t.string :vc_entity_name
      t.string :vc_entity_siglum
      t.integer :vc_entity_viaf_work_id
      t.string :vc_entity_viaf_work_link
      t.string :vc_entity_standard_title
      t.string :vc_entity_standard_title_source
      t.text :vc_entity_notes
      t.integer :vc_user_id
      t.string :vc_user_name
      t.string :vc_user_action
      t.datetime :vc_date_time_stamp

      t.timestamps
    end
  end
end
