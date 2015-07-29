class OwnershipsController < ApplicationController
  def new
    @book = current_user.books.new
    @ownership = current_user.ownerships.new
  end

  def create
    current_user.ownerships.create(ownership_params)
    render status: 201, json: user_path(current_user)
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
