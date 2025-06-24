class GroupsController < ApplicationController
  before_action :set_group, only: [ :update ]

  def index
    render json: GroupsSerializer.render_as_hash(Group.all)
  end

  def create
    @group = Group.build(group_params)

    if @group.save
      render json: @group, status: :created, location: @group
    else
      render json: @group.errors, status: :unprocessable_entity
    end
  end

  def update
    if @group.update(group_params)
      render json: GroupsSerializer.render(@group)
    else
      render json: @group.errors, status: :unprocessable_entity
    end
  end

  private

  def set_group
    @group ||= Group.find(params[:id])
  end

  def group_params
    params.permit(:title, :description, :subjects_file, :statement_head_text)
  end
end
