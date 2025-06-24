class AddTeacherComment < ActiveRecord::Migration[7.1]
  def change
    add_column :subjects_teachers, :comment, :string
  end
end
