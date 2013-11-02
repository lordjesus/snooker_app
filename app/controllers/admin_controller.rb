class AdminController < ApplicationController
	require 'RMagick'

	before_action :admin_user
	def users
		@pending_users = User.where(:is_valid => false)
  		@valid_users = User.where(:is_valid => true)	
  		img = Magick::Image.new(30, 200){self.background_color = 'white'}
  		Magick::Draw.new.annotate(img, 10, 10, 10, 0, 'DM 2012 / 2013') {
  			self.font_family = 'Helvetica'
  			self.fill = 'black'
  			self.stroke = 'transparent'
  			self.pointsize = 13
  			self.rotation = 90
  		}
  		img.trim!
  		img.write('/tmp/test2.jpg')
	end

	def players
		@players = Player.all.order("club_id")
	end

	def tournaments 
		@current_tournaments = Tournament.where(:finished => 0).where(['deadline < ?', DateTime.now])
			

		@future_tournaments = Tournament.where(:finished => 0).where(['deadline > ?', DateTime.now])

		@previous_tournaments = Tournament.where(:finished => 1)
	end

	def clubs
		@clubs = Club.all 
	end

	def approve_user
		@user = User.find(params[:id])
		@user.update_attribute(:is_valid, true)
		redirect_to admin_users_path
	end

	def deactivate_user
		@user = User.find(params[:id])
		@user.update_attribute(:is_valid, false)
		redirect_to admin_users_path
	end

	private

  	def admin_user
      redirect_to(root_url) unless current_user && current_user.admin?
    end
end
