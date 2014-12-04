class CreateSurrogates < ActiveRecord::Migration
  def change
    create_table :surrogates do |t|
      t.integer :item_id
      t.integer :manifestation_id
      t.string :surrogate_local_title
      t.string :surrogate_local_description
      t.boolean :surrogate_active
      t.text :surrogate_notes

      t.timestamps
    end
  end
end
