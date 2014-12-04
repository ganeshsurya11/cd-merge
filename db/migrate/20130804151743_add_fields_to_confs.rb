class AddFieldsToConfs < ActiveRecord::Migration
  def change
    add_column :confs, :conf_publisher, :string
    add_column :confs, :conf_publisher_url, :string
    add_column :confs, :conf_publisher_location, :string
    add_column :confs, :conf_publisher_license, :text
    add_column :confs, :conf_site_editor_name, :string
  end
end
