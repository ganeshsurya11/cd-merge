class AddNewFrbrModelFieldsToPages < ActiveRecord::Migration
  def change
    add_column :pages, :digital_edition_id, :integer
  end
end
