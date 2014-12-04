class CreateItemsHasDigitalEditions < ActiveRecord::Migration
  def change
    create_table :items_has_digital_editions do |t|
      t.integer :item_id
      t.integer :digital_edition_id
      t.boolean :item_has_digital_edition_primary

      t.timestamps
    end
  end
end
