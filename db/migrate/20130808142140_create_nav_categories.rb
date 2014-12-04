class CreateNavCategories < ActiveRecord::Migration
  def change
    create_table :nav_categories do |t|
      t.string :nav_category_name
      t.integer :nav_category_order

      t.timestamps
    end
  end
end
