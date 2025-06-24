class AddTemplateForTeacherResponse < ActiveRecord::Migration[7.1]
  def change
    create_table :templates do |t|
      t.string :title
      t.text :text
      t.references :teacher

      t.timestamps
    end
  end
end
