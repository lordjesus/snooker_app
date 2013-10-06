class Tournament < ActiveRecord::Base
	has_many :enter, foreign_key: "tournament_id", dependent: :destroy
	has_many :players, through: :enter
end
