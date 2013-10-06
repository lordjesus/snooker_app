class CreateEnters < ActiveRecord::Migration
  def change
    create_table :enters do |t|
      t.integer :player_id
      t.integer :tournament_id
      t.string :note
      t.integer :rank
      t.boolean :lost_all

      t.timestamps
    end

    add_index :enters, :player_id
    add_index :enters, :tournament_id
    add_index :enters, [:player_id, :tournament_id], unique: true
  end
end
