class AddNewFrbrModelFieldsToLines < ActiveRecord::Migration
  def change
    add_column :lines, :work_id, :integer
    add_column :lines, :expression_id, :integer
    add_column :lines, :digital_edition_id, :integer
    add_column :lines, :line_work_order, :integer
  end
end
