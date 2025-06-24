class SubjectsTeacher < ApplicationRecord
  belongs_to :subject
  belongs_to :teacher
  belongs_to :request

  state_machine initial: :pending do
    event :pend do
      transition any => :pending
    end

    event :approve do
      transition [:pending, :rejected] => :approved
    end

    event :reject do
      transition [:pending, :approved] => :rejected
    end
  end

  def humanize_state_text
    rejected? ? 'відхилив' : "прийняв"
  end
end
  