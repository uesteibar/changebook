class BooksController < ApplicationController
  before_action :authenticate_user!, except: [:search]

  def index
    @books = Book.all
    render status: 200, json: @books
  end

  def show
    @book = Book.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render status: 200, json: @book }
    end
  end

  def create
    Book.create(book_params)
    redirect_to new_ownership_path
  end

  def search
    books = Book.search_offered_by_title(params[:term])
    render status: 200, json: books
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, :cover, :genre_id)
  end
end
