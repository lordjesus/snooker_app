class TournamentsController < ApplicationController
	require 'RMagick'
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
			if @tournament.max_points > 0
				generate_header(@tournament)
				update_ranking_list
			end
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
		@players = @tournament.players.order("position ASC")

		@pointList = {
			1 => 100 * @tournament.max_points / 100,
			2 => 80 * @tournament.max_points / 100,
			3 => 64 * @tournament.max_points / 100,
			4 => 50 * @tournament.max_points / 100,
			5 => 38 * @tournament.max_points / 100,
			6 => 28 * @tournament.max_points / 100, 
			7 => 23 * @tournament.max_points / 100,
			8 => 18 * @tournament.max_points / 100,
			9 => 13 * @tournament.max_points / 100,
			10 => 8 * @tournament.max_points / 100,
			11 => 3 * @tournament.max_points / 100
		}

		

		if is_admin?(current_user)
			if @players.count > 0
				@not_joined = Player.find(:all, :conditions => ['id not in (?)', @players.map(&:id)], :order => "club_id")
			else
				@not_joined = Player.all.order(:club_id)
			end

		elsif is_club_leader?(current_user)
			if @players.count > 0
				@not_joined = Player.find(:all, :conditions => ['club_id = ? AND id not in (?)',current_user.player.club_id, @players.map(&:id)])
			else
				@not_joined = Player.all.where(:club_id => current_user.player.club_id)
			end
		end			

		if @tournament.finished == 1

			@results = @tournament.enter.order(:rank)

			@rankList = Hash.new()

			rank = 1
			rCount = 0
			rStartCount = 1

			@results.each do |res|
				if !res.rank.nil?

					if res.rank > rank
						# write current ranks and increment to next rank
						if rStartCount == rCount
							@rankList[rank] = rCount.to_s
						else
							@rankList[rank] = rStartCount.to_s + " - " + rCount.to_s
						end
						rank = rank + 1
						rCount = rCount + 1
						rStartCount = rCount
					else
						rCount = rCount + 1
					end
				end
			end

			@rankList[rank] = rStartCount.to_s + " - " + rCount.to_s


			@breaks = @tournament.high_break
		end
	end

	def index
		@tournaments = Tournament.where(['deadline > ?', DateTime.now]).order("start_date ASC")
		@current_tournaments = Tournament.where('finished = 0 and final_date > now() and deadline < now()')
		@previous_tournaments = Tournament.where("finished = 1 and final_date < now() and final_date > '2000-01-01 00:00:00'").order("final_date DESC")
	end

	private

	  def generate_header(tournament)
		img = Magick::Image.new(30, 300){self.background_color = 'white'}
  		Magick::Draw.new.annotate(img, 10, 10, 10, 0, tournament.name) {
  			self.font_family = 'Helvetica'
  			self.fill = 'black'
  			self.stroke = 'transparent'
  			self.pointsize = 13
  			self.rotation = 90
  		}
  		img.trim!  		
  		file = Tempfile.new(["tournament#{tournament.id}",'.png'])
  		img.write(file.path)
  		tournament.header_image = file 
  		tournament.save! unless Rails.env.development? # Uncomment in production!
	  end

	  def update_ranking_list
	  	played = Hash.new


	  	tournaments = Tournament.all.where(:finished => 1).where("max_points > 0").order('final_date desc').limit(7).reverse
	  	players = Player.all
	  	players.each do |player|
	  		player.ranking_points = 0
	  		player.save
	  		played[player.id] = 0;
	  	end
	  	tournaments.each do |tour|
	  		if tour.header_image_file_name == nil
	  			generate_header(tour)
	  		end
	  		enters = tour.enter
	  		enters.each do |row|
	  			player = players.find(row.player_id)
				if (row.points)
	  				player.ranking_points += row.points
	  				played[player.id] = played[player.id] + 1	  				
	  				player.save
	  			end
	  		end
	  	end
	  	# TODO: Handle cases with equal points
	  	# by favouring the best latest result
	  	players = players.order('ranking_points desc')
	  	i = 1
	  	cur = players.first
	  	players.each do |p|
	  		p.last_position = p.position
	  		p.position = i
	  		i += 1
	  		p.save
	  		Ranking.create(:player_id => p.id, :tournament_id => tournaments.last.id,
	  		 	:ranking => p.position, :ranking_points => p.ranking_points, 
	  		 	:tournaments_played => played[p.id])

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
