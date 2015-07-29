class BooksController < ApplicationController
  before_action :authenticate_user!, except: [:all_titles]

  def show
    @book = Book.find(params[:id])
    @offering_count = @book.offerings_count
  end

  def create
    Book.create(book_params)
    redirect_to new_ownership_path
  end

  def all
    books = Book.all
    render status: 200, json: books
  end

  def one
    book = Book.find(params[:id])
    render status: 200, json: book
  end

  def search
    books = Book.search_by_title(params[:term])
    render status: 200, json: books
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :cover)
  end
end
