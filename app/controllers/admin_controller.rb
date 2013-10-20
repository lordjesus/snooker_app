class AdminController < ApplicationController
	before_action :admin_user
	def users
		@pending_users = User.where(:is_valid => false)
  		@valid_users = User.where(:is_valid => true)	
	end

	def players
		@players = Player.all
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
