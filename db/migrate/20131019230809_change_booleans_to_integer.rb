class ChangeBooleansToInteger < ActiveRecord::Migration
  def change
  	change_column :enters, :lost_all, :integer, :default => 0
  	change_column :enters, :gone, :integer, :default => 0
  end
end
