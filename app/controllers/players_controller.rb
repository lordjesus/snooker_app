class PlayersController < ApplicationController
  def new
  	@player = Player.new
  end

  def index 
  	@players = Player.find(:all, :order => "ranking_points DESC")
  end

  def show
  	@player = Player.find(params[:id])
  end

  def create
  	@player = Player.new(player_params)
  	if @player.save
  		# Success
  		flash[:success] = "Spiller oprettet"
  		redirect_to @player
  	else
  		# Fail
  		render 'new'
  	end
  end

  private

    def player_params
    	params.require(:player).permit(:name, :club_id, :ranking_points)
    end
end
