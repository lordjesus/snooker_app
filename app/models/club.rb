class Club < ActiveRecord::Base
	has_many :players	
	has_many :tournaments
	validates(:name, presence: true, length: { minimum: 2 },
    	uniqueness: { case_sensitive: false })
	validates(:address, presence: true)
	validates(:number_of_tables, presence: true)
end
