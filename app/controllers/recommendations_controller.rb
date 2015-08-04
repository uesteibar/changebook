class RecommendationsController < ApplicationController
  before_action :authenticate_user!

  def new
    @recommendation = Book.find(params[:book_id]).recommendations.new
  end

  def create
    book = Book.find(params[:book_id])
    current_user.recommend(book, recommendation_params[:comment], recommendation_params[:valoration])
    redirect_to user_path(current_user)
  end

  def destroy
    recommendation = current_user.recommendations.find(params[:id])
    recommendation.destroy
    redirect_to user_path(current_user)
  end

  private

  def recommendation_params
    params.require(:recommendation).permit(:comment, :valoration)
  end
end
