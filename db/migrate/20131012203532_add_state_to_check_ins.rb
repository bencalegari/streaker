class AddStateToCheckIns < ActiveRecord::Migration
  def change
    add_column :check_ins, :state, :string
  end
end
