class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.integer :is_valid
      t.integer :user_level

      t.timestamps
    end
  end
end
