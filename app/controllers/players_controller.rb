class PlayersController < ApplicationController
  def new
  end

  def index 
  	@players = Player.find(:all, :order => "ranking_points DESC")
  end
end
