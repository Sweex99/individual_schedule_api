class TeachersController < ApplicationController

  def index
    search_term = params[:search].downcase
    @teachers = Teacher.where("LOWER(first_name) LIKE ? OR LOWER(last_name) LIKE ?", "%#{search_term}%", "%#{search_term}%")
    render json: @teachers.order(:first_name, :last_name)
  end

end
