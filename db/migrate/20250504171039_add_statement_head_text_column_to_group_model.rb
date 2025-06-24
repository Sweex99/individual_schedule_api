class AddStatementHeadTextColumnToGroupModel < ActiveRecord::Migration[7.1]
  def change
    add_column :groups, :statement_head_text, :text
  end
end
