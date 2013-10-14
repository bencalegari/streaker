class AddStartAndEndTimeToCheckIns < ActiveRecord::Migration
  def change
    add_column :check_ins, :start_time, :datetime
    add_column :check_ins, :end_time, :datetime
  end
end
