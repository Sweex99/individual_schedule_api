class RelationBetweenSubjectsAndTeachers < ActiveRecord::Migration[7.1]
  def change
    create_table :subjects_teachers do |t|
      t.references :subject
      t.references :teacher

      t.timestamps
    end
  end
end
