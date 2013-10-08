class Player < ActiveRecord::Base
	belongs_to :club
	has_many :enter, foreign_key: "player_id", dependent: :destroy
	has_many :tournaments, through: :enter

	def enter!(tournament) 
		enter.create(tournament_id: tournament.id)
	end

	def unenter!(tournament) 
		enter.find_by(tournament_id: tournament.id).destroy!
	end

	def entering?(tournament)
		enter.find_by(tournament_id: tournament.id)
	end
end
