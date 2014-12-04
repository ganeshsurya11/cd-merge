class RemoveColumnsFromLines < ActiveRecord::Migration
  def up
    remove_column :lines, :entity_id
    remove_column :lines, :surrogate_id
    remove_column :lines, :line_entity_order
  end

  def down
    add_column :lines, :line_entity_order, :integer
    add_column :lines, :surrogate_id, :integer
    add_column :lines, :entity_id, :integer
  end
end
