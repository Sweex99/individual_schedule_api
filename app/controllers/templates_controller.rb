class TemplatesController < ApplicationController
  before_action :set_request, only: [:show, :update, :destroy]

  def index
    render json: current_user.templates
  end

  def show
    render json: current_user.templates.find(params[:id])
  end

  def create
    @template = current_user.templates.build(request_params)

    if @template.save
      render json: @template, status: :created, location: @template
    else
      render json: @template.errors, status: :unprocessable_entity
    end
  end

  def update
    if @template.update(request_params)
      render json: @template
    else
      render json: @template.errors, status: :unprocessable_entity
    end
  end

  def destroy
    render json @request.destroy
  end

  private

  def set_request
    @request = Template.find(params[:id])
  end

  def request_params
    params.require(:template).permit(:text, :title)
  end
end
