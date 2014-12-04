class CreateTeiBuilds < ActiveRecord::Migration
  def change
    create_table :tei_builds do |t|
      t.integer :digital_edition_id
      t.text :tei_build_tei

      t.timestamps
    end
  end
end
