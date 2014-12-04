class AddConfSplashToConfs < ActiveRecord::Migration
  def change
    add_column :confs, :conf_splash, :text
  end
end
