class RemovePageAssetFromPages < ActiveRecord::Migration
  def up
    remove_column :pages, :page_asset
  end

  def down
    add_column :pages, :page_asset, :string
  end
end
