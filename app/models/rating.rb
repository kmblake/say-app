class Rating < ActiveRecord::Base
	belongs_to :user
	belongs_to :document, counter_cache: true
	belongs_to :artwork, counter_cache: true
	validates :rating_val, presence: true

  after_commit :update_rating_avg

  private 
  def update_rating_avg
    if self.document
      self.document.update_average
    else
      self.artwork.update_average
    end
  end
end
