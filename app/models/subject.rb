class Subject < ApplicationRecord
  has_many :subjects_teachers
  has_many :teachers, -> { distinct }, through: :subjects_teachers
end
