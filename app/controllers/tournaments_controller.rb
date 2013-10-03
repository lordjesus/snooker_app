class TournamentsController < ApplicationController
	def new
		@tournament = Tournament.new 
	end

	def create
		@tournament = Tournament.new(tournament_params)
		if @tournament.save
			# Success
			flash[:success] = 'Turnering oprettet'
			redirect_to @tournament
		else
			render 'new'
		end
	end

	def show
		@tournament = Tournament.find(params[:id])
	end

	private

	  def tournament_params
	  	params.require(:tournament).permit(:name, :start_date, :final_date, :deadline,
	  		:entry_fee, :club_id, :alternate_club_id, :max_points)
	  end
end
