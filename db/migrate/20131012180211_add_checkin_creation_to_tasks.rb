class AddCheckinCreationToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :last_checkin_creation, :datetime
  end
end
