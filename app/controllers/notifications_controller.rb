class NotificationsController < ApplicationController
  def index
    @transfer_requests = current_user.received_transfers
    @notifications = current_user.unread_notifications
  end

  def mark_read
    notification = Notification.find(params[:id])
    notification.update_attributes(read: true)
    redirect_to notifications_path
  end
end
