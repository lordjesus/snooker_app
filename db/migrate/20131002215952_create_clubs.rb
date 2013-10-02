class CreateClubs < ActiveRecord::Migration
  def change
    create_table :clubs do |t|
      t.string :name
      t.string :address
      t.integer :number_of_tables

      t.timestamps
    end
  end
end
