class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :remember_token

      t.timestamps
    end
    add_index :users, :email, unique: true
    add_index  :users, :remember_token
  end

  def down
  	drop_table :users
  end

end
