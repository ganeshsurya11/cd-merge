class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works do |t|
      t.string :work_name
      t.string :work_siglum
      t.integer :work_viaf_id
      t.string :work_viaf_link
      t.text :work_notes

      t.timestamps
    end
  end
end
