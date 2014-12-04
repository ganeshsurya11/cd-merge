class AddNewFrbrModelFieldsToWorks < ActiveRecord::Migration
  def change
    add_column :works, :work_frbr, :boolean
    add_column :works, :work_standard_title, :string
    add_column :works, :work_standard_title_source, :string
  end
end
