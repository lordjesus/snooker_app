class EntersController < ApplicationController

	def create
		@player = Player.find(params[:enter][:player_id])
		@tournament = Tournament.find(params[:enter][:tournament_id])
		@player.enter!(@tournament)
		if current_user.player == @player 
			flash[:success] = 'Du er nu tilmeldt'			
		else
			flash[:success] = "Du har nu tilmeldt #{@player.name}"
		end
		if @player.user 
		#	UserMailer.user_joined_tournament(@player.user, @tournament).deliver
		end
		redirect_to @tournament
	end

	def destroy
		@player = Player.find(params[:enter][:player_id])
		@tournament = Tournament.find(params[:enter][:tournament_id])
		@player.unenter!(@tournament)
		if current_user.player == @player 
			flash[:success] = 'Du er nu afmeldt'
		else
			flash[:success] = "Du har nu afmeldt #{@player.name}"
		end
		if @player.user 
		#	UserMailer.user_left_tournament(@player.user, @tournament).deliver
		end
		redirect_to @tournament
	end
end
