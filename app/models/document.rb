class Document < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :ratings
  has_attached_file :file

  validates :title, presence: true
  
  # disallows multiple submissions of a single style
  validates :style, style: true

  validates_attachment_presence :file
  validates_attachment_content_type :file, :content_type => ["application/pdf",
             "application/msword", 
             "application/vnd.openxmlformats-officedocument.wordprocessingml.document", 
             "text/plain"]

  STYLES = %w[Fiction Nonfiction Poetry]
  MAX_DOCUMENTS = 3
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
    Rating.exists?(:user_id => editor.id, :document_id => id)
  end

end
