class Profile < ActiveRecord::Base
	belongs_to :player

	has_attached_file :avatar, styles: {
		medium: '300x300'
	}
end