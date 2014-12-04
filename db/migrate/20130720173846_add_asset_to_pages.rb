class AddAssetToPages < ActiveRecord::Migration
  def change
    add_column :pages, :page_asset, :string
  end
end
