class AddWorkShortCodeToWorks < ActiveRecord::Migration
  def change
  	add_column :works, :work_short_code, :string
  end
end
