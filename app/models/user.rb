class User < ActiveRecord::Base
    belongs_to :player
	before_save { self.email = email.downcase }
	before_save { self.username = username.downcase }
	before_create :create_remember_token
	validates(:username, presence: true, length: { maximum: 50 },
    	uniqueness: { case_sensitive: false })
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates(:email, presence: true, format: { with: VALID_EMAIL_REGEX },
    	uniqueness: { case_sensitive: false })
    has_secure_password
    validates :password, length: { minimum: 6 }
    validates :player_id, presence: :true

    def User.new_remember_token
    	SecureRandom.urlsafe_base64
    end

    def User.encrypt(token)
    	Digest::SHA1.hexdigest(token.to_s)
    end

    def admin?
        self.user_level == 2
    end

    def club_leader?
        self.user_level == 1
    end

    def send_password_reset
        s = SecureRandom.urlsafe_base64 + DateTime.now.to_i.to_s
        k = Digest::SHA1.hexdigest(s)
        self.update_attribute(:reset_token, k)
        self.update_attribute(:reset_sent_at, DateTime.now)
        UserMailer.password_reset(self).deliver
    end

    private 

    	def create_remember_token
    		self.remember_token = User.encrypt(User.new_remember_token)
    	end
end
