class ClubsController < ApplicationController
  def new
  end

  def index
  	@clubs = Club.all 
  end

  def show
  	@club = Club.find(params[:id])
  	@players = @club.players
  end
end
