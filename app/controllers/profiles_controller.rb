class ProfilesController < ApplicationController
	def new
	 	@profile = Profile.new
	 	@profile.player_id = params[:player_id]
	end

	def create
		@profile = Profile.new(profile_params)
		if @profile.save
  			# Success
  			flash[:success] = "Profil oprettet"
  			redirect_to @profile.player
  		else
  			# Fail
  			render 'new'
  		end
	end

	def edit
		@profile = Profile.find(params[:id])
	end

	def update
		@profile = Profile.find(params[:id])
		if @profile.update_attributes(profile_params)
      		flash[:success] = "Profil opdateret"
      		redirect_to @profile.player 
    	else
      		render 'edit'
    	end
	end

	private

		def profile_params
			params.require(:profile).permit(:born_year, :start_year, :cue,
				:training_week, :fav_training, :highest_break_tournament,
				:highest_break_practice, :best_result, :best_match,
				:favourite_player, :hobbies, :fav_music, :fav_movie,
				:email, :phone, :player_id, :avatar)
		end
end
