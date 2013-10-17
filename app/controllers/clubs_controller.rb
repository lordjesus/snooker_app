class ClubsController < ApplicationController
	before_action :admin_user,	 only: [:new, :create, :destroy, :edit, :update]

  def new
    @club = Club.new
  end

  def edit
    @club = Club.find(params[:id])
  end

  def update 
    @club = Club.find(params[:id])
    if @club.update_attributes(club_params)
      flash[:success] = "Klub opdateret"
      redirect_to @club 
    else
      render 'edit'
    end
  end

  def index
  	@clubs = Club.all 
  end

  def show
  	@club = Club.find(params[:id])
  	@players = @club.players
  end

  def create
    @club = Club.new(club_params)
    if @club.save
      # Success
      flash[:success] = "Klub oprettet"
      redirect_to @club
    else
      # Fail
      render 'new'
    end
  end

  private


    def club_params
      params.require(:club).permit(:name, :address, :number_of_tables)
    end

  	def admin_user
      redirect_to(root_url) unless current_user && current_user.admin?
    end
end
