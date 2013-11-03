class AddImageToTournaments < ActiveRecord::Migration
  def change
  	add_column :tournaments, :header_image, :bytea
  end
end
