class AddGoneToEnters < ActiveRecord::Migration
  def change
  	add_column :enters, :gone, :boolean
  end
end
