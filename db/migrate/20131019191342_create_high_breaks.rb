class CreateHighBreaks < ActiveRecord::Migration
  def change
    create_table :high_breaks do |t|
      t.integer :player_id
      t.integer :tournament_id
      t.integer :match_id
      t.integer :break

      t.timestamps
    end
  end
end
