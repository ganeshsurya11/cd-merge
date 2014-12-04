class CreateUserRoles < ActiveRecord::Migration
  def change
    create_table :user_roles do |t|
      t.string :user_roles_role
      t.text :user_roles_notes

      t.timestamps
    end
  end
end
