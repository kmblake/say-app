class Artwork < ActiveRecord::Base
  belongs_to :user, counter_cache: true
  has_many :comments, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_attached_file :image, :styles => {:medium => "800x800>", :thumb => "100x100>" }

  after_save :update_accepted_count, if: :accepted_changed?
  after_destroy :update_accepted_count

  validates_attachment_presence :image
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]
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

  def update_average
    average = Rating.where(artwork_id: self.id).average(:rating_val)
    update_attribute(:average_rating, average)
  end

  def secureUrl(size)
    self.image.url(size).insert(4, 's')
  end

  def get_average_rating
    if Settings.show_ratings
      if self.average_rating
        return self.average_rating.round(2)
      else
        return "n/a"
      end
    else
      return "hidden"
    end
  end

  def update_accepted_count
    u = self.user
    u.accepted_art_count = u.artworks.where(accepted:true).count
    u.save
  end

  def self.gimme_another(current_user)
    already_rated = Artwork.joins(:ratings).where("ratings.user_id = #{current_user.id}").pluck(:id)
    if already_rated.length == Artwork.count()
      return -1
    else
      minRatingsCount = Artwork.where.not(id: already_rated).minimum(:ratings_count)
      return Artwork.select(:id).where(ratings_count: minRatingsCount).where.not(id: already_rated).order("RANDOM()").first.id
    end
  end

end
