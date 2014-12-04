class AddNavFieldsToDigitalEditions < ActiveRecord::Migration
  def change
    add_column :digital_editions, :nav_category_id, :integer
    add_column :digital_editions, :digital_edition_order, :integer
  end
end
