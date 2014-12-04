class CreateEntities < ActiveRecord::Migration
  def change
    create_table :entities do |t|
      t.string :entity_name
      t.string :entity_siglum
      t.integer :entity_viaf_work_id
      t.string :entity_viaf_work_link
      t.string :entity_standard_title
      t.string :entity_standard_title_source
      t.text :entity_notes

      t.timestamps
    end
  end
end
