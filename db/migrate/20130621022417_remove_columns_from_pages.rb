class RemoveColumnsFromPages < ActiveRecord::Migration
  def up
    remove_column :pages, :surrogate_id
  end

  def down
    add_column :pages, :surrogate_id, :integer
  end
end
