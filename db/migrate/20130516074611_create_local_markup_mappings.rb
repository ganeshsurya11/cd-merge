class CreateLocalMarkupMappings < ActiveRecord::Migration
  def change
    create_table :local_markup_mappings do |t|
      t.string :local_markup_map_token
      t.string :local_markup_map_tei

      t.timestamps
    end
  end
end
