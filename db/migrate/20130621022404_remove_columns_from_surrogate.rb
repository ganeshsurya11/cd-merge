class RemoveColumnsFromSurrogate < ActiveRecord::Migration
  def up
    remove_column :surrogates, :entity_id
    remove_column :surrogates, :manifestation_id
  end

  def down
    add_column :surrogates, :manifestation_id, :integer
    add_column :surrogates, :entity_id, :integer
  end
end
