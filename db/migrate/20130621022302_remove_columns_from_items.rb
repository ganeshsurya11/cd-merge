class RemoveColumnsFromItems < ActiveRecord::Migration
  def up
    remove_column :items, :expression_id
  end

  def down
    add_column :items, :expression_id, :integer
  end
end
