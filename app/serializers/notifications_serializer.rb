class NotificationsSerializer < Blueprinter::Base
  identifier :id
  fields :text, :read

  view :with_user do
    association :user, blueprint: UsersSerializer
  end
end