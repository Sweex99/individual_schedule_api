class SubjectsTeachersSerializer < Blueprinter::Base
  identifier :id

  fields :state, :comment, :created_at

  association :subject, blueprint: SubjectsSerializer
  association :teacher, blueprint: UsersSerializer
 
  view :teacher do
    association :request, blueprint: RequestsSerializer, view: :with_student
  end
end