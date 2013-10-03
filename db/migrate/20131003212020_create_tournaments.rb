class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.string :name
      t.datetime :start_date
      t.datetime :final_date
      t.datetime :deadline
      t.integer :entry_fee
      t.integer :number_of_players
      t.integer :club_id
      t.integer :alternate_club_id
      t.integer :max_points

      t.timestamps
    end
  end
end
