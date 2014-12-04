class CreateSystemEventTypes < ActiveRecord::Migration
  def change
    create_table :system_event_types do |t|
      t.string :system_event_type_type
      t.text :system_event_type_notes

      t.timestamps
    end
  end
end
