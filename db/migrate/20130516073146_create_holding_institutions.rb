class CreateHoldingInstitutions < ActiveRecord::Migration
  def change
    create_table :holding_institutions do |t|
      t.string :holding_institution_name
      t.string :holding_institution_siglum
      t.text :holding_institution_notes

      t.timestamps
    end
  end
end
