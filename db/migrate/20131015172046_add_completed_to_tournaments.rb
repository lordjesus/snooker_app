class AddCompletedToTournaments < ActiveRecord::Migration
  def change
  	add_column :tournaments, :finished, :boolean
  end
end
