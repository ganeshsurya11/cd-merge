class AddNewFrbrModelFieldsToExpressions < ActiveRecord::Migration
  def change
    add_column :expressions, :work_id, :integer
  end
end
