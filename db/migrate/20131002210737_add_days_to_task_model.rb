class AddDaysToTaskModel < ActiveRecord::Migration
  def change
    add_column :tasks, :days, :string
  end
end
