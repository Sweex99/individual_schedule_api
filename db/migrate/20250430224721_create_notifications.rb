class CreateNotifications < ActiveRecord::Migration[7.1]
  def change
    create_table :notifications do |t|
      t.string :text
      t.references :user
      t.boolean :read, default: false

      t.timestamps
    end
  end
end
