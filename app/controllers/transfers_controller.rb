class TransfersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user, only: [:index, :create]

  def index
    @transfer_requests = current_user.received_transfers
  end

  def create
    # TODO - create a transfer request
  end

  private

  def transfer_params
    params.require(:transfer).permit(:ownership_id)
  end
end
