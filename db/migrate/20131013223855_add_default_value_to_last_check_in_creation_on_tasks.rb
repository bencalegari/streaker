class AddDefaultValueToLastCheckInCreationOnTasks < ActiveRecord::Migration
  def up
    remove_column :tasks, :last_checkin_creation, :datetime
    add_column :tasks, :last_checkin_creation, :datetime, default: DateTime.new(1991, 10, 4)
  end

  def down
    remove_column :tasks, :last_checkin_creation, :datetime, default: DateTime.new(1991, 10, 4)
    add_column :tasks, :last_checkin_creation, :datetime
  end
end

