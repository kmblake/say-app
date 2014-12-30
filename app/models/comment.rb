class Comment < ActiveRecord::Base
	belongs_to :user
	belongs_to :document
	belongs_to :artwork
	validates :comment_text, presence: true
end
