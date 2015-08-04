class TransfersController < ApplicationController
  before_action :authenticate_user!

  def create
    ownership_to_transfer = Ownership.find(params[:ownership_id])
    transfer_request = current_user.request_transfer(ownership_to_transfer)
    TransferRequestMailer.transfer_request_received_mail(transfer_request.ownership.user, transfer_request).deliver_later
    redirect_to "/"
  end

  def accept
    transfer_to_accept = current_user.received_transfers.find(params[:id])
    transfer_to_accept.accept!
    redirect_to user_path(current_user)
  end

  def destroy
    current_user.reject_transfer_request(params[:id])
    redirect_to notifications_path
  end
end
