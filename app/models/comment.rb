class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :document
	belongs_to :artwork
end
