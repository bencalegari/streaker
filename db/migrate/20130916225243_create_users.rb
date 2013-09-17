class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :password
      t.integer :phone_number
      t.integer :checkin_pass

      t.timestamps
    end
  end
end
