class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name, :null => false
      t.string :description 
      t.boolean :remindable, :null => false, :default => false
      t.integer :user_id

      t.timestamps
    end
  end
end
