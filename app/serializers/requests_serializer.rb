class RequestsSerializer < Blueprinter::Base
  identifier :id
  fields :state, :created_at

  field :image_url do |record|
    Rails.application.routes.url_helpers.rails_blob_url(record.hire_document, host: ENV['BACK_END_URL']) if record.hire_document.blob
  end
  
  association :reason, blueprint: ReasonsSerializer

  view :with_student do
    association :student, blueprint: UsersSerializer
    association :subjects_teachers, blueprint: SubjectsTeachersSerializer
  end
end