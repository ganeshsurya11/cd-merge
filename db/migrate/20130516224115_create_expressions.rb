class CreateExpressions < ActiveRecord::Migration
  def change
    create_table :expressions do |t|
      t.integer :expression_type_id
      t.string :expression_name
      t.string :expression_siglum
      t.string :expression_description
      t.text :expression_notes

      t.timestamps
    end
  end
end
