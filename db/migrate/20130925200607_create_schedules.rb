class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.integer :start
      t.integer :duration

      t.timestamps
    end
  end
end
