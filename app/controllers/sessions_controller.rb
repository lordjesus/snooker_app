class SessionsController < ApplicationController

	def new 
	end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if !user			
			user = User.find_by(username: params[:session][:email].downcase)
		end
		if user && user.authenticate(params[:session][:password])
			# Sign in
			sign_in user
			redirect_back_or user
		else 
			# Error
			flash.now[:error] = 'Forkert email/password kombination'
			render 'new'
		end		
	end

	def destroy
		sign_out
		redirect_to root_url
	end		

end
