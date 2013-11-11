class PasswordResetsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(:email => params[:email])
  	# send reset to user
  	if (user)
  		
      user.send_password_reset
      flash[:success] = "Email med password instruktioner er sendt"
      
  	else 
  		flash[:danger] = 'Ingen bruger med denne email'
  	end
  	redirect_to root_url
  end

  def edit
    @user = User.find_by(:reset_token => params[:id]) unless params[:id] == nil
  end

  def update
    @user = User.find_by(:reset_token => params[:id])
    if @user.reset_sent_at < 2.hours.ago
      flash[:danger] = 'Nulstillingsperioden for dette password er ophørt'
      redirect_to new_password_reset_path
    elsif @user.update_attributes(user_params)
      @user.update_attribute(:reset_token, nil)
      @user.update_attribute(:reset_sent_at, nil)
      flash[:success] = "Password er nu ændret!"
      redirect_to root_url 
    else
      render :edit
    end
      
  end

  private

    def user_params
      params.require(:user).permit(:username, :email, :password, 
        :password_confirmation, :player_id)
    end
end
