class Rating < ActiveRecord::Base
	belongs_to :user
	belongs_to :document
	belongs_to :artwork
	validates :rating_val, presence: true
end
