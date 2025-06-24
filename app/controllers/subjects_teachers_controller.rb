class SubjectsTeachersController < ApplicationController
  before_action :subjects_teacher, only: [:update, :destroy]

  def index
    data = params[:state] == 'all' || params[:state] == '' ? current_user.subjects_teachers : current_user.subjects_teachers.where(state: params[:state])

    render json: SubjectsTeachersSerializer.render_as_hash(data, view: :teacher)
  end

  def create
    s = SubjectsTeacher.new(subjects_teachers_params)

    if s.save
      Notification.create(user_id: subjects_teachers_params[:teacher_id], text: "Новий запит від студента: #{current_user.first_name + " " + current_user.last_name}")
      render json: s.to_json, status: 200
    else
      render json: { errors: ['asd']}, status: 500
    end
  end

  def update
    if subjects_teacher.update(update_subjects_teachers_params)
      subjects_teacher.send(params[:state])
      Notification.create(user_id: subjects_teacher.request.student.id, text: "Викладач #{subjects_teacher.teacher.full_name} - #{subjects_teacher.humanize_state_text} ваш запит для предмету - #{subjects_teacher.subject.name}")
      render json: SubjectsTeachersSerializer.render_as_hash(subjects_teacher, view: :teacher), status: 200
    else
      render json: { errors: ['asd']}, status: 500
    end
  end

  def destroy
    subjects_teacher.destroy
  end

  private

  def subjects_teachers_params
    params.permit(:subject_id, :teacher_id, :request_id)
  end

  def update_subjects_teachers_params
    params.permit(:comment)
  end

  def subjects_teacher
    @subjects_teacher ||= SubjectsTeacher.find(params[:id])
  end
end
    