class AddItemIdToDigitalEditions < ActiveRecord::Migration
  def change
    add_column :digital_editions, :item_id, :integer
  end
end
