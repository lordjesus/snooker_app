class ClubsController < ApplicationController
	before_action :admin_user,	 only: [:new, :create, :destroy]
  def new
  end

  def index
  	@clubs = Club.all 
  end

  def show
  	@club = Club.find(params[:id])
  	@players = @club.players
  end

  private

  	def admin_user
      redirect_to(root_url) unless current_user && current_user.admin?
    end
end
