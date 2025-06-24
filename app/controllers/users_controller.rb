class UsersController < ApplicationController
  before_action :set_user, only: [:update]

  def index
    render json: UsersSerializer.render_as_hash(User.all)
  end

  def update
    if @user.update(user_params)
      render json: UsersSerializer.render(@user)
    else
      render json: { errors: ['asd']}, status: 500
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :type, :grand_teacher)
  end

  def set_user
    @user ||= User.find(params[:id])
  end
  
end
    