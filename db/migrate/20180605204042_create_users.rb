class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password
      t.string :email
      t.integer :exploded, default: 0
      t.integer :defused, default: 0

      t.timestamps
    end
  end
end
