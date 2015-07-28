class BooksController < ApplicationController
  before_action :authenticate_user!

  def new
    @book = current_user.books.new
  end

  def create
    current_user.books.create(book_params)
    redirect_to user_path(current_user)
  end

  def destroy
    book = current_user.books.find(params[:id])
    book.destroy
    redirect_to user_path(current_user)
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :cover, :to_give_away, :to_exchange)
  end
end
