class AddRequestKeyToSubjectsTeacherModel < ActiveRecord::Migration[7.1]
  def change
    add_reference :subjects_teachers, :request
  end
end
