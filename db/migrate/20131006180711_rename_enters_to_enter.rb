class RenameEntersToEnter < ActiveRecord::Migration
  def change
  	rename_table :enters, :enter 
  end
end
