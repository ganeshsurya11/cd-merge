class CreateAgents < ActiveRecord::Migration
  def change
    create_table :agents do |t|
      t.string :agent_last_name
      t.string :agent_first_name
      t.string :agent_middle_name
      t.string :agent_name_prefix
      t.string :agent_name_suffix
      t.integer :agent_birth_year
      t.integer :agent_death_year
      t.integer :agent_viaf_id
      t.string :agent_viaf_link
      t.string :agent_viaf_type
      t.text :agent_notes

      t.timestamps
    end
  end
end
