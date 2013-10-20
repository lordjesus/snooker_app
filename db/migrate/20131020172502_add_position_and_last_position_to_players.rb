class AddPositionAndLastPositionToPlayers < ActiveRecord::Migration
  def change
  	add_column :players, :position, :integer
  	add_column :players, :last_position, :integer
  end
end
