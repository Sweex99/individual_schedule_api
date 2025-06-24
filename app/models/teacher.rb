class Teacher < User
  has_many :subjects_teachers
  has_many :subjects, through: :subjects_teachers

  has_many :templates
end