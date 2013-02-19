class CreateAppointments < ActiveRecord::Migration
  def up
  	create_table :appointments do |t|
      t.integer :task_id
      t.integer :user_id

      t.timestamps
    end

    add_index :appointments, [:user_id, :task_id], :unique => true
  end

	 def down
	 	drop_table :appointments
	 end
	 
end
