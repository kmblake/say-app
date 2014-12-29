class User < ActiveRecord::Base
  self.inheritance_column = 'role'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :documents, dependent: :destroy
  has_many :artworks, dependent: :destroy

  ROLES = %w[Submitter Editor Admin]

  # Needs to be half of min PW length
  HEX_LENGTH = 3

  # validates :first_name, :last_name, presence: true 

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

end
