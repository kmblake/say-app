class Artwork < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_attached_file :image, :styles => {:medium => "800x800>", :thumb => "100x100>" }

  validates_attachment_presence :image
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  validates :title, :user_id, presence: true

  MAX_ARTWORKS = 3
  RATINGS = [1, 2, 3, 4]

  def avg_rating
    total = 0
    for rating in ratings
      total += rating.rating_val
    end
    avg = total.to_f / ratings.count
    if avg.nan?
      return 0.0
    else 
      return avg
    end
  end

  def already_rated(editor)
    Rating.exists?(:user_id => editor.id, :artwork_id => id)
  end
end
