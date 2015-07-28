class BooksController < ApplicationController
  before_action :authenticate_user!, except: [:all_titles]

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

  def all_titles
    books = Book.all
    render status: 200, json: books
  end

  def search
    books = Book.where("UPPER(title) LIKE ?", "%#{params[:term].upcase}%")
    render status: 200, json: books
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :cover, :to_give_away, :to_exchange)
  end
end
