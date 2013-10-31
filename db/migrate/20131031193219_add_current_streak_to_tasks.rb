class AddCurrentStreakToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :current_streak, :integer, default: 0
  end
end
