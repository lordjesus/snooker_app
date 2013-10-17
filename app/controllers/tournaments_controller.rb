class TournamentsController < ApplicationController
	before_action :admin_user,    only: [:new, :create, :destroy, :edit, :update, :finish]

	def new
		@tournament = Tournament.new 
	end

	def finish
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

	def edit
		@tournament = Tournament.find(params[:id])
	end

  	def update 
    	@tournament = Tournament.find(params[:id])
    	if @tournament.update_attributes(tournament_params)
      		flash[:success] = "Turnering opdateret"
      		redirect_to admin_tournaments_path 
    	else
      		render 'edit'
    	end
  	end

	def show
		@tournament = Tournament.find(params[:id])
		@players = @tournament.players.find(:all, :order => "ranking_points DESC")
		if @players.count > 0
			@not_joined = Player.find(:all, :conditions => ['id not in (?)', @players.map(&:id)])
		else
			@not_joined = Player.all
		end
	end

	def index
		@tournaments = Tournament.where(['final_date > ?', DateTime.now]).order("start_date ASC")
	end

	private

	  def tournament_params
	  	params.require(:tournament).permit(:name, :start_date, :final_date, :deadline,
	  		:entry_fee, :club_id, :alternate_club_id, :max_points)
	  end

	  def admin_user
        redirect_to(root_url) unless current_user && current_user.admin?
      end
end
