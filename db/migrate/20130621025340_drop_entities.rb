class DropEntities < ActiveRecord::Migration
  def change
    drop_table :entities
  end
end
