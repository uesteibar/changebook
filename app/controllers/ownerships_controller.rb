class OwnershipsController < ApplicationController
  before_action :authenticate_user!

  def new
    @book = current_user.books.new
    @ownership = current_user.ownerships.new
  end

  def create
    ownership = current_user.ownerships.create(ownership_params)
    render status: 201, json: ownership
  end

  def update
    ownership = Ownership.find(params[:id])
    ownership.destroy_events
    ownership.update_attributes(
      to_give_away: ownership_params[:to_give_away],
      to_exchange: ownership_params[:to_exchange]
    )
    ownership.create_events
    render status: 200, json: ownership
  end

  def destroy
    ownership = Ownership.find(params[:id])
    ownership.destroy
    redirect_to user_path(current_user)
  end

  private

  def ownership_params
    params.require(:ownership).permit(:book_id, :to_give_away, :to_exchange)
  end
end
