class PlayersController < ApplicationController
  before_action :admin_user,    only: [:new, :create, :destroy]
  before_action :correct_user,  only: [:edit, :update]

  def new
  	@player = Player.new
  end

  def edit
  end

  def update    
    if @player.update_attributes(player_params)
      flash[:success] = "Spiller opdateret"
      redirect_to @player 
    else
      render 'edit'
    end
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
  		redirect_to admin_players_path
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

    def correct_user
      @player = Player.find(params[:id])
      redirect_to(root_url) unless current_user && (current_user?(@player.user) || current_user.admin?)
    end
end
