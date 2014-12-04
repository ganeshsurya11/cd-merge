class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.integer :surrogate_id
      t.integer :page_page
      t.string :page_image
      t.text :page_notes

      t.timestamps
    end
  end
end
