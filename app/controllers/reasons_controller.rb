class ReasonsController < ApplicationController
  before_action :set_reason, only: [ :update ]

  def index
    render json: ReasonsSerializer.render_as_hash(Reason.all)
  end

  def create
    @reason = Reason.build(reason_params)

    if @reason.save
      render json: @reason, status: :created, location: @reason
    else
      render json: @reason.errors, status: :unprocessable_entity
    end
  end

  def update
    if @reason.update(reason_params)
      render json: ReasonsSerializer.render(@reason)
    else
      render json: @reason.errors, status: :unprocessable_entity
    end
  end

  private

  def set_reason
    @reason ||= Reason.find(params[:id])
  end

  def reason_params
    params.permit(:title, :description)
  end
end
