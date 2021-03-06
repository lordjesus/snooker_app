class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  def show
  	@user = User.find(params[:id])
    if @user.is_valid
      redirect_to @user.player
    end
  end

  def new
  	@user = User.new
  end

  def edit  	
  end

  def update  	
  	if @user.update_attributes(user_params)
  		flash[:success] = "Brugerprofil opdateret"
  		redirect_to @user 
  	else
  		render 'edit'
  	end
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
  		sign_in @user
      UserMailer.user_created(@user).deliver
  		flash[:success] = "Velkommen til snooker app"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  def accept_user
    user = User.find(params[:id])
    user.update_attribute(:is_valid, true)
    redirect_to admin_path
  end

  private 

  	def user_params
  		params.require(:user).permit(:username, :email, :password, 
  			:password_confirmation, :player_id)
  	end

  	# Before filters
  	def signed_in_user
  		unless signed_in?
  			store_location
  			flash[:notice] = "Log venligst ind."
  			redirect_to signin_url
  		end
  	end

  	def correct_user
  		@user = User.find(params[:id])
  		redirect_to(root_url) unless current_user?(@user) || is_admin?(current_user)
  	end
  			
  		

end
