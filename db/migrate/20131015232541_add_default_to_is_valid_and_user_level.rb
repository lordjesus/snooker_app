class AddDefaultToIsValidAndUserLevel < ActiveRecord::Migration
  def change
  	change_column :users, :is_valid, :boolean, :default => false
  	change_column :users, :user_level, :integer, :default => 0
  end
end
