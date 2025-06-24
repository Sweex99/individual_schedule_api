class SubjectsSerializer < Blueprinter::Base
  identifier :id

  fields :name, :hours_count

  view :with_related_teachers do
    association :teachers, blueprint: UsersSerializer
  end
end