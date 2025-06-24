class CreateSubjects < ActiveRecord::Migration[7.1]
  def change
    create_table :subjects do |t|
      t.string :name
      t.string :hours_count

      t.timestamps
    end
  end
end
