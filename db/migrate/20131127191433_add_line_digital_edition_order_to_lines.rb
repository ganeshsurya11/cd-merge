class AddLineDigitalEditionOrderToLines < ActiveRecord::Migration
  def change
    add_column :lines, :line_digital_edition_order, :integer
  end
end
