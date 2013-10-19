class RenameEntersBack < ActiveRecord::Migration
  def change
  	rename_table :enter, :enters 
  end
end
