class CreateDigitalEditions < ActiveRecord::Migration
  def change
    create_table :digital_editions do |t|
      t.string :digital_edition_local_title
      t.string :digital_edition_description
      t.boolean :digital_edition_active
      t.text :digital_edition_notes

      t.timestamps
    end
  end
end
