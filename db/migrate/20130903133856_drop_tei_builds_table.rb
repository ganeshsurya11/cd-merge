class DropTeiBuildsTable < ActiveRecord::Migration
  def up
    drop_table :tei_builds
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
