class CreateConfs < ActiveRecord::Migration
  def change
    create_table :confs do |t|
      t.boolean :config_active
      t.boolean :conf_group_expression_type
      t.boolean :conf_group_manifestation_type
      t.boolean :conf_build_concordance
      t.boolean :conf_build_variants
      t.string :conf_contact_email
      t.boolean :conf_contact_form
      t.string :conf_site_name
      t.string :conf_site_tagline
      t.string :conf_site_domain_name
      t.string :conf_site_httpd_root
      t.string :conf_site_transcription_root
      t.string :conf_site_facsimile_root
      t.string :conf_site_xslt_directory

      t.timestamps
    end
  end
end
