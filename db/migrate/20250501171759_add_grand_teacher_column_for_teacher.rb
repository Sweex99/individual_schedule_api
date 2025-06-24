class AddGrandTeacherColumnForTeacher < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :grand_teacher, :boolean, default: false
  end
end
