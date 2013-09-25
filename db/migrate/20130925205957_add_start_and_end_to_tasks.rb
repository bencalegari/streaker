class AddStartAndEndToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :start, :datetime, null: false
    add_column :tasks, :end, :datetime, null: false
  end
end
