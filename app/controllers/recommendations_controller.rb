class RecommendationsController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    current_user.recommend(book, recommendation_params[:comment])
    redirect_to user_path(current_user)
  end

  private

  def recommendation_params
    params.require(:recommendation).permit(:comment)
  end
end
