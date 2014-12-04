class AddVariantUrlToDigitalEditions < ActiveRecord::Migration
  def change
    add_column :digital_editions, :digital_edition_variant_list_url, :string
  end
end
