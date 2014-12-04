class CreateVcHoldingInstitutions < ActiveRecord::Migration
  def change
    create_table :vc_holding_institutions do |t|
      t.integer :vc_id
      t.string :vc_holding_institution_name
      t.string :vc_holding_institution_siglum
      t.text :vc_holding_institution_notes
      t.integer :vc_user_id
      t.string :vc_user_name
      t.string :vc_user_action
      t.datetime :vc_date_time_stamp

      t.timestamps
    end
  end
end
