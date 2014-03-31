class PlayersController < ApplicationController
  require 'gchart'
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
    @ranking_players = Player.all.where('ranking_points > 0').order('position ASC')
  	#@players = Player.find(:all, :order => "ranking_points DESC")
    @tournaments = Tournament.all.where(:finished => 1).where("max_points > 0").order('final_date desc').limit(6).reverse
    @non_ranking_players = Player.all.where('ranking_points = 0').order('name')  
  end

  def show
  	@player = Player.find(params[:id])
    @tournaments_played = @player.enter.where(
      "tournament_id IN (SELECT DISTINCT(id) FROM tournaments WHERE finished = 1 and final_date > '2000-01-01 00:00:00')")
      .includes(:tournament)
      .order("tournaments.final_date DESC")
    @ranking_history = @player.rankings.includes(:tournament)
      .order("tournaments.final_date DESC")
      max = @ranking_history.maximum(:ranking)
      @count = 1
      if max 
        while max > 0
          @count = @count + 1
          max = max - 5
        end
      end
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

  def get_rank(x)
      case x
        when 1
          "1"
        when 2
          "2"
        when 3
          "3-4"
        when 4
          "5-8"
        when 5
          "9-16"
        when 6
          "17-20"
        when 7
          "21-24"
        when 8
          "25-32"
        when 9
          "33-40"
        else
          "Uden for rækkevidde"
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
