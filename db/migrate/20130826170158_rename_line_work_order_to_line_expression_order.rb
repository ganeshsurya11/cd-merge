class RenameLineWorkOrderToLineExpressionOrder < ActiveRecord::Migration
  def up
  	rename_column :lines, :line_work_order, :line_expression_order
  end

  def down
  	rename_column :lines, :line_expression_order, :line_work_order
  end
end
