class RemoveCheckins < ActiveRecord::Migration
  def change
    drop_table :schedules
  end
end
