class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :player_id
      t.string :born_year
      t.string :start_year
      t.string :cue
      t.string :training_week
      t.string :fav_training
      t.string :highest_break_tournament
      t.string :highest_break_practice
      t.text :best_result
      t.text :best_match
      t.text :favourite_player
      t.text :hobbies
      t.text :fav_music
      t.text :fav_movie

      t.timestamps
    end
  end
end
