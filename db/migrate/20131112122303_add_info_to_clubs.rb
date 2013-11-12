class AddInfoToClubs < ActiveRecord::Migration
  def change
  	add_column :clubs, :phone, :string
  	add_column :clubs, :email, :string
  	add_column :clubs, :web_page, :string
  end
end
