class GroupsSerializer < Blueprinter::Base
  identifier :id
  fields :title, :description, :statement_head_text
end