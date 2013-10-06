class Player < ActiveRecord::Base
	belongs_to :club
	has_many :enter, foreign_key: "player_id", dependent: :destroy
	has_many :tournaments, through: :enter
end
