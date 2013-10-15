module TournamentsHelper

	def has_joined?(tournament)
		Enter.find_by(player_id: current_user.player.id, tournament_id: tournament.id)
	end

end
