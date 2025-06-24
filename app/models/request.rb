class Request < ApplicationRecord
  has_one_attached :hire_document

  belongs_to :student, foreign_key: :user_id
  accepts_nested_attributes_for :student

  belongs_to :reason, foreign_key: :reason_id

  has_many :subjects_teachers, dependent: :destroy
  has_many :teachers, through: :subjects_teachers

  scope :actual, -> { where.not(state: [:cancelled, :fully_approved]).last }

  state_machine initial: :submitted do
    event :submit do
      transition any => :submitted
    end

    event :deanery_approve do
      transition submitted: :deanery_approved
    end

    event :department_approve do
      transition [:deanery_approved, :teacher_approved] => :department_approved
    end

    event :teacher_approve do
      transition department_approved: :teacher_approved
    end

    event :fully_approve do
      transition teacher_approved: :fully_approved
    end

    event :reject do
      transition [:submitted, :teacher_approved, :fully_approved, :department_approved, :deanery_approved] => :rejected
    end

    event :cancell do
      transition [:teacher_approved, :fully_approved, :department_approved, :deanery_approved, :rejected] => :cancelled
    end
  end
end
