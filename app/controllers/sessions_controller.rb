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

	def redirect_back_or(default)
		redirect_to(session[:return_to] || default)
		session.delete(:return_to)
	end

	def store_location
		session[:return_to] = request.url if request.get
	end

end
