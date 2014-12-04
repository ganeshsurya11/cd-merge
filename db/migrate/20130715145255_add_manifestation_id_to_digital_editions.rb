class AddManifestationIdToDigitalEditions < ActiveRecord::Migration
  def change
    add_column :digital_editions, :manifestation_id, :integer
  end
end
