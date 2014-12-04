class AddLineDvStartCodeToLines < ActiveRecord::Migration
  def change
    add_column :lines, :line_dv_start_code, :string
  end
end
