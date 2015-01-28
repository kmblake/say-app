class Rating < ActiveRecord::Base
	belongs_to :user
	belongs_to :document, counter_cache: true
	belongs_to :artwork, counter_cache: true
	validates :rating_val, presence: true

  private 
  def update_average
    if self.document
      self.document.update_average
    else
      self.artwork.update_average
    end
  end
end
