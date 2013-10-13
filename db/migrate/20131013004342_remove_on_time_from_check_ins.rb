class RemoveOnTimeFromCheckIns < ActiveRecord::Migration
  def change
    remove_column :check_ins, :on_time, :string
  end
end
