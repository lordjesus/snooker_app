class TournamentsController < ApplicationController
	before_action :admin_user,    only: [:new, :create, :destroy]

	def new
		@tournament = Tournament.new 
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

	def show
		@tournament = Tournament.find(params[:id])
		@players = @tournament.players.find(:all, :order => "ranking_points DESC")
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
