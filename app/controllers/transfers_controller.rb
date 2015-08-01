class TransfersController < ApplicationController
  before_action :authenticate_user!

  def create
    current_user.request_transfer(Ownership.find(params[:ownership_id]))
    redirect_to "/"
  end

  def accept
    current_user.received_transfers.find(params[:id]).accept!
    redirect_to user_path(current_user)
  end

  def destroy
    current_user.reject_tranfer_request(params[:id])
    redirect_to notifications_path
  end
end
