class CreateEventTypes < ActiveRecord::Migration
  def change
    create_table :event_types do |t|
      t.string :event_type_type
      t.string :event_type_description
      t.text :event_type_notes

      t.timestamps
    end
  end
end
