class ChangeTournamentFinishedToInteger < ActiveRecord::Migration
  def change
  	change_column :tournaments, :finished, :integer, :default => 0
  end
end
