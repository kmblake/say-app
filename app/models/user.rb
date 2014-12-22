class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :documents
  has_many :artworks

  ROLES = %w[submitter editor admin]

  validates :first_name, :last_name, :school, :teacher, :grade, :bio, presence: true 

  def role?(base_role)
    ROLES.index(base_role.to_s) <= ROLES.index(role)
  end

  def name 
    first_name + " " + last_name
  end
end
