class Artwork < ActiveRecord::Base
  belongs_to :user
  has_attached_file :image, :styles => {:medium => "800x800>", :thumb => "100x100>" }

  validates_attachment_presence :image
  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  validates :title, presence: true

  MAX_ARTWORKS = 3
end
