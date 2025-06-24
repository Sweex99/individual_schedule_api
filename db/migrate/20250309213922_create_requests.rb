class CreateRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :requests do |t|
      t.string :state
      t.boolean :deanery_approved
      t.boolean :department_approved

      t.timestamps
    end
  end
end
