class User < ActiveRecord::Base
  self.inheritance_column = 'role'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :documents
  has_many :artworks

  ROLES = %w[Submitter Editor Admin]

  validates :first_name, :last_name, presence: true 

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

end
