class Tournament < ActiveRecord::Base
	has_many :enter, foreign_key: "tournament_id", dependent: :destroy
	has_many :players, through: :enter
	has_many :high_break
	belongs_to :club
	belongs_to :alternate_club, :class_name => "Club", :foreign_key => "alternate_club_id"
end
