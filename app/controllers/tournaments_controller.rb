class TournamentsController < ApplicationController
	before_action :admin_user,    only: [:new, :create, :destroy, :edit, :update, :finish]

	def new
		@tournament = Tournament.new 
	end

	def finish
		@tournament = Tournament.find(params[:id])
		@players = @tournament.players.find(:all, :order => "ranking_points DESC")
		@enters = @tournament.enter.find(:all)
	end

	def done
		@tournament = Tournament.find(params[:id])
		Rails.logger.info()
		Rails.logger.info("PARAMS INSPECT: #{params.inspect}")
		Rails.logger.info("Done")

		keyList = {
			1 => 100,
			2 => 80,
			3 => 64,
			4 => 50,
			5 => 38,
			6 => 28,
			7 => 23,
			8 => 18,
			9 => 13,
			10 => 8,
			11 => 3
		}
		
		enters = @tournament.enter

		enters.each do |enter|
			if params["#{enter.player_id}"]["gone"]
				enter.gone = params["#{enter.player_id}"]["gone"]
			end
			if enter.gone == 0
				enter.rank = params["#{enter.player_id}"]["rank"]
				if params["#{enter.player_id}"]["lost"]
					enter.lost_all = params["#{enter.player_id}"]["lost"]
				end
				points = keyList[enter.rank] * @tournament.max_points / 100
				if enter.lost_all == 1
					points /= 2
				end
				enter.points = points

				if params["#{enter.player.id}"]["breaks"].size > 0
					breaks = params["#{enter.player.id}"]["breaks"].split(",").map(&:strip)
					breaks.each do |b|
						HighBreak.create(:player_id => enter.player.id,
							:tournament_id => @tournament.id, :break => b.to_i)
					end
				end
			end
			
			enter.save
		end
		
		@tournament.finished = 1;
		if @tournament.save
			update_ranking_list
			flash[:success] = 'Turnering afsluttet'
			redirect_to admin_tournaments_path
		else
			flash[:alert] = 'Fejl i afslutning af turnering'
			render 'finish'
		end
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

	  def update_ranking_list
	  	tournaments = Tournament.all.where(:finished => 1).order('final_date desc').limit(6).reverse
	  	players = Player.all
	  	players.each do |player|
	  		player.ranking_points = 0
	  		player.save
	  	end
	  	tournaments.each do |tour|
	  		enters = tour.enter
	  		enters.each do |row|
	  			player = players.find(row.player_id)
				if (row.points)
	  				player.ranking_points += row.points
	  				player.save
	  			end
	  		end

	  	#	players.each do |player|
	  	#		row = enters.find_by(:player_id => player.id)
	  	#		if (row.points)
	  	#			player.ranking_points += row.points
	  	#		end
	  	#	end
	  	end

	  end

	  def tournament_params
	  	params.require(:tournament).permit(:name, :start_date, :final_date, :deadline,
	  		:entry_fee, :club_id, :alternate_club_id, :max_points)
	  end

	  def admin_user
        redirect_to(root_url) unless current_user && current_user.admin?
      end
end
