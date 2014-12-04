class CreateVcWorksHasExpressions < ActiveRecord::Migration
  def change
    create_table :vc_works_has_expressions do |t|
      t.integer :vc_id
      t.integer :vc_work_id
      t.integer :vc_expression_id
      t.integer :vc_user_id
      t.string :vc_user_name
      t.string :vc_user_action
      t.datetime :vc_date_time_stamp

      t.timestamps
    end
  end
end
