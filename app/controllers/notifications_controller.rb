class NotificationsController < ApplicationController
  before_action :set_notification, only: %i[ read destroy ]

  def index
    @notifications = current_user.notifications.order('created_at desc')

    render json: NotificationsSerializer.render_as_hash(@notifications)
  end

  def read
    if @notification.read!
      render json: @notification
    else
      render json: @notification.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @notification.destroy!
  end

  private

  def set_notification
    @notification = Notification.find(params[:id])
  end
end
