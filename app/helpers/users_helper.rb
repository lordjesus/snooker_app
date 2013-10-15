module UsersHelper
	def is_admin?(user) 
		user && user.admin?
	end
end
