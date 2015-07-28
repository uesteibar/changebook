class BooksController < ApplicationController
  before_action :authenticate_user!

  def new
    @book = current_user.books.new
  end

  def create
    book = OpenlibraryClient.new.search_book(book_params[:title])
    book.assign_attributes(to_give_away: book_params[:to_give_away], to_exchange: book_params[:to_exchange])
    book.save
    current_user.books << book
    redirect_to user_path(current_user)
  end

  private

  def book_params
    params.require(:book).permit(:title, :to_give_away, :to_exchange)
  end
end
