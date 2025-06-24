class AddStateToSubjectTeacherModel < ActiveRecord::Migration[7.1]
  def change
    add_column :subjects_teachers, :state, :string
  end
end
