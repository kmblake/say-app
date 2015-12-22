class Document < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :ratings, dependent: :destroy
  has_attached_file :file

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

end
