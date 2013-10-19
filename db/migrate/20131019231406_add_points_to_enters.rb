class AddPointsToEnters < ActiveRecord::Migration
  def change
  	add_column :enters, :points, :integer
  end
end
