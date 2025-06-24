class CreateReasons < ActiveRecord::Migration[7.1]
  def change
    create_table :reasons do |t|
      t.string :title
      t.string :description

      t.timestamps
    end

    add_reference :requests, :reason
  end
end
