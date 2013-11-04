class CreateRankings < ActiveRecord::Migration
  def change
    create_table :rankings do |t|
      t.integer :player_id
      t.integer :tournament_id
      t.integer :ranking
      t.integer :ranking_points
      t.integer :tournaments_played
      t.timestamps
    end
  end
end
