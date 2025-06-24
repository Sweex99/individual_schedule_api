class RemoveUnnncesaryColumn < ActiveRecord::Migration[7.1]
  def change
    remove_column :requests, :deanery_approved, :string
    remove_column :requests, :department_approved, :string
  end
end
