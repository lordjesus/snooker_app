class AddHeaderImageToTournaments < ActiveRecord::Migration
  def change
  	add_attachment :tournaments, :header_image
  end
end
