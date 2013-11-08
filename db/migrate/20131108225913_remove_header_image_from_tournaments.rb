class RemoveHeaderImageFromTournaments < ActiveRecord::Migration
  def change
  	remove_column :tournaments, :header_image
  end
end
