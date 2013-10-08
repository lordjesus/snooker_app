class EntersController < ApplicationController

	def create
		@player = Player.find(params[:enter][:player_id])
		@tournament = Tournament.find(params[:enter][:tournament_id])
		@player.enter!(@tournament)
		flash[:success] = 'Du er nu tilmeldt'
		redirect_to @tournament
	end

	def destroy
		@player = Player.find(params[:enter][:player_id])
		@tournament = Tournament.find(params[:enter][:tournament_id])
		@player.unenter!(@tournament)
		flash[:success] = 'Du er nu afmeldt'
		redirect_to @tournament
	end
end
