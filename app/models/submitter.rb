class Submitter < User;

  validates :school, :teacher, :grade, :bio, presence: true

  GRADES = [6, 7, 8]

end