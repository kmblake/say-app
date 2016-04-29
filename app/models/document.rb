class Document < ActiveRecord::Base
  belongs_to :user, counter_cache: true
  has_many :comments, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_attached_file :file

  after_save :update_accepted_count, if: :accepted_changed?
  after_destroy :update_accepted_count

  validates :title, :user_id, presence: true
  
  # To disallow multiple submissions of a single style, uncomment the next line
  # validates :style, style: true

  validates_attachment_presence :file
  validates_attachment_content_type :file, :content_type => ["application/pdf",
             "application/msword", 
             "application/vnd.openxmlformats-officedocument.wordprocessingml.document"]

  STYLES = %w[Fiction Nonfiction Poetry]
  STATUS = {under_review: 'Under Review', accepted: 'Accepted', rejected: 'Not Accepted'}
  MAX_DOCUMENTS = 2
  RATINGS = [1, 2, 3, 4]

  # def avg_rating
  #   total = 0
  #   for rating in ratings
  #     total += rating.rating_val
  #   end
  #   avg = total.to_f / ratings.count
  #   if avg.nan?
  #     return 0.0
  #   else 
  #     return avg
  #   end
  # end

  def already_rated(editor)
    Rating.exists?(:user_id => editor.id, :document_id => id)
  end

  def submitter
    User.find(user_id)
  end

  def update_average
    average = Rating.where(document_id: self.id).average(:rating_val)
    update_attribute(:average_rating, average)
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

  def secureUrl
    self.file.url.insert(4, 's')
  end

  def update_accepted_count
    u = self.user
    u.accepted_doc_count = u.documents.where(accepted:true).count
    u.save
  end

  def self.gimme_another(current_user)
    already_rated = Document.joins(:ratings).where("ratings.user_id = #{current_user.id}").pluck(:id)
    if already_rated.length == Document.count()
      return -1
    else
      minRatingsCount = Document.where.not(id: already_rated).minimum(:ratings_count)
      return Document.select(:id).where(ratings_count: minRatingsCount).where.not(id: already_rated).order("RANDOM()").first.id
    end
  end

  def self.categorize(minFlag, minAccept)
    Document.all.each do |doc| 
      if doc.average_rating < minAccept and doc.average_rating >= minFlag then doc.flag = true end
      if doc.ratings.count == 2
        ratings = doc.ratings.pluck(:rating_val)
        if (ratings[0] - ratings[1]).abs >= 2 then doc.flag = true end
      end
      if doc.average_rating >= minAccept then doc.accepted = true end
      doc.save()
    end
  end

end
