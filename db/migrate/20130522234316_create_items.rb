class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :expression_id
      t.integer :manifestation_id
      t.integer :holding_institution_id
      t.string :item_siglum
      t.string :item_description
      t.string :item_shelfmark
      t.text :item_notes

      t.timestamps
    end
  end
end
