class UsersSerializer < Blueprinter::Base
  identifier :id

  fields :first_name, :last_name

  field :type do |record|
    record.class.name
  end

  field :semester, if: -> (_field_name, user, options) { user.type === 'Student' }
  field :gender, if: -> (_field_name, user, options) { user.type === 'Student' }

  association :group, blueprint: GroupsSerializer, if: -> (_field_name, user, options) { user.type === 'Student' }

  field :grand_teacher, if: -> (_field_name, user, options) { user.type === 'Teacher' }
end