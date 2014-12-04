class CreateVcExpressions < ActiveRecord::Migration
  def change
    create_table :vc_expressions do |t|
      t.integer :vc_id
      t.string :vc_expression_name
      t.string :vc_expression_siglum
      t.string :vc_expression_description
      t.text :vc_expression_notes
      t.integer :vc_user_id
      t.string :vc_user_name
      t.string :vc_user_action
      t.datetime :vc_date_time_stamp

      t.timestamps
    end
  end
end
