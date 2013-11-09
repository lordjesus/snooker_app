class Profile < ActiveRecord::Base
	belongs_to :player

	has_attached_file :avatar, styles: {
		medium: '300x300',
		thumb: '100x100>'
	}, :default_url => "https://s3-eu-west-1.amazonaws.com/snookerdk/profiles/avatars/:style/missing.png"
end