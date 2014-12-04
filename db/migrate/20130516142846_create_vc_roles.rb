class CreateVcRoles < ActiveRecord::Migration
  def change
    create_table :vc_roles do |t|
      t.integer :vc_id
      t.string :vc_role_role
      t.text :vc_role_ntoes
      t.integer :vc_user_id
      t.string :vc_user_name
      t.string :vc_user_action
      t.datetime :vc_date_time_stamp

      t.timestamps
    end
  end
end
