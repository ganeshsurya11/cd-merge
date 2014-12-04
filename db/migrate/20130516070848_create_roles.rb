class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :role_role
      t.string :role_description
      t.text :role_notes

      t.timestamps
    end
  end
end
