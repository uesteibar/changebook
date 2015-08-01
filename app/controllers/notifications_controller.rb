class NotificationsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @transfer_requests = current_user.received_transfers
    @notifications = current_user.unread_notifications
  end

  def mark_read
    notification = Notification.find(params[:id])
    notification.mark_as_read
    redirect_to notifications_path
  end
end
