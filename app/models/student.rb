class Student < User
  has_many :requests, foreign_key: :user_id

  belongs_to :group, optional: true
end