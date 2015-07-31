class TransfersController < ApplicationController
  before_action :authenticate_user!

  def index
    @transfer_requests = current_user.received_transfers
  end

  def create
    current_user.request_transfer(Ownership.find(params[:ownership_id]))
    redirect_to "/"
  end

  def accept
    current_user.received_transfers.find(params[:id]).accept!
    redirect_to user_path(current_user)
  end
end
