class User < ActiveRecord::Base
  self.inheritance_column = 'role'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :documents, dependent: :destroy
  has_many :artworks, dependent: :destroy
  has_many :comments
  has_many :ratings


  ROLES = %w[Submitter Editor Admin]

  # Needs to be half of min PW length
  HEX_LENGTH = 3

  validates :first_name, :last_name, presence: true 

  attr_accessor :temp_pw

  def role?(base_role)
    ROLES.index(base_role.to_s) <= ROLES.index(role)
  end

  def name 
    first_name + " " + last_name
  end

  def toggle_admin
    if self.role == "Editor"
      self.role = "Admin"
    elsif self.role == "Admin"
      self.role = "Editor"
    end
    self.save
  end

  def random_pw
    pw = SecureRandom.hex(HEX_LENGTH)
    self.password = pw
    self.temp_pw = pw
  end

  def rated_all(type)
    if type == 'Document'
      Document.joins(:ratings).where("ratings.user_id = #{self.id}").count() == Document.count()
    else 
      Artwork.joins(:ratings).where("ratings.user_id = #{self.id}").count() == Artwork.count()
    end
  end

  # def reset_ratings_counters
  #   self.doc_ratings_count = self.ratings.where.not(document_id: nil).count()
  #   self.art_ratings_count = self.ratings.where.not(artwork_id: nil).count()
  #   self.save
  # end

  # def update_avg_rating(type)
  #   if type == :document
  #     avg = ratings.where.not(document_id: nil).average(:rating_val)
  #     update_attribute(:doc_average_rating, avg)
  #   else
  #     avg = ratings.where.not(artwork_id: nil).average(:rating_val)
  #     update_attribute(:art_average_rating, avg)
  #   end
  # end


  def avg_art_rating
    avg = ratings.where.not(document_id: nil).average(:rating_val)
    if avg then avg.round(2) else "N/A" end
  end

  def avg_doc_rating
    avg = ratings.where.not(artwork_id: nil).average(:rating_val)
    if avg then avg.round(2) else "N/A" end
  end

  # SELECT AVG("ratings"."rating_val") AS avg_id FROM "ratings"  WHERE "ratings"."user_id" = $1 AND ("ratings"."document_id" IS NOT NULL)

  ransacker :full_name do |parent|
    Arel::Nodes::InfixOperation.new('||',
      Arel::Nodes::InfixOperation.new('||', parent.table[:first_name], ' '),
      parent.table[:last_name])
  end

end
