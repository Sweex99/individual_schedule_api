class AddMoreColumnsForUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :semester, :integer
    add_column :users, :gender, :integer
    add_column :users, :group_id, :bigint
  end
end
