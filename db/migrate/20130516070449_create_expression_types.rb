class CreateExpressionTypes < ActiveRecord::Migration
  def change
    create_table :expression_types do |t|
      t.string :expression_type_type
      t.string :expression_type_description
      t.text :expression_type_note

      t.timestamps
    end
  end
end
