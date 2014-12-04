class AddLineDesignatorToLines < ActiveRecord::Migration
  def change
    add_column :lines, :line_designator, :string
  end
end
