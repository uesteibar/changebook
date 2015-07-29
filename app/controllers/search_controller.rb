class SearchController < ApplicationController
  before_action :authenticate_user!

  def search
    @users = User.search_by_username(params[:term])
    @books = Book.search_by_title(params[:term])
  end
end
