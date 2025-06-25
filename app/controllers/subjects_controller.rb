class SubjectsController < ApplicationController
  before_action :set_subject, only: [ :update ]

  def index
    search_term = params[:search]&.downcase
    @subjects = Subject.where("LOWER(name) LIKE ?", "%#{search_term}%")

    render json: SubjectsSerializer.render_as_hash(@subjects.order('updated_at desc'), view: :with_related_teachers)
  end

  def update
    if @subject.update(subject_params)
      render json: SubjectsSerializer.render(@subject)
    else
      render json: @subject.errors, status: :unprocessable_entity
    end
  end

  def create
    @subject = Subject.build(subject_params)

    if @subject.save
      render json: @subject, status: :created, location: @subject
    else
      render json: @subject.errors, status: :unprocessable_entity
    end
  end

  private

  def set_subject
    @subject ||= Subject.find(params[:id])
  end

  def subject_params
    params.require(:subject).permit(:name, :hours_count)
  end
end
