class Player < ActiveRecord::Base
	belongs_to :club
	has_one :user
	has_one :profile
	has_many :high_break
	has_many :rankings, foreign_key: "player_id"
	has_many :enter, foreign_key: "player_id", dependent: :destroy
	has_many :tournaments, through: :enter
	validates(:name, presence: true, length: { minimum: 2 },
    	uniqueness: { case_sensitive: false })
	validates(:club_id, presence: true)
	self.per_page = 10

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
