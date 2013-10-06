class Enter < ActiveRecord::Base
	belongs_to :player, class_name: "Player"
	belongs_to :tournament, class_name: "Tournament"
	validates :player_id, presence: true
	validates :tournament_id, presence: true
end
