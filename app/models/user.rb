class User < ActiveRecord::Base
	before_save { self.email = email.downcase }
	before_save { self.username = username.downcase }
	validates(:username, presence: true, length: { maximum: 50 },
    	uniqueness: { case_sensitive: false })
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates(:email, presence: true, format: { with: VALID_EMAIL_REGEX },
    	uniqueness: { case_sensitive: false })
    has_secure_password
    validates :password, length: { minimum: 6 }
end
