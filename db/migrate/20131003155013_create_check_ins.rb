class CreateCheckIns < ActiveRecord::Migration
  def change
    create_table :check_ins do |t|
      t.integer :task_id, null: false
      t.boolean :on_time, default: false
      t.timestamps
    end
  end
end
