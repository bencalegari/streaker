class AddCurrentStreakToUser < ActiveRecord::Migration
  def change
    add_column :users, :current_streak, :integer, default: 0
  end
end
