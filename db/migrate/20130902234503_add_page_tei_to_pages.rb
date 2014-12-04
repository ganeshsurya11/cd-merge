class AddPageTeiToPages < ActiveRecord::Migration
  def change
    add_column :pages, :page_tei, :text
  end
end
