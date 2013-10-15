class PlayersController < ApplicationController
  before_action :admin_user,    only: [:new, :create, :destroy]

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

    def admin_user
      redirect_to(root_url) unless current_user && current_user.admin?
    end
end
