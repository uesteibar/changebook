class SearchController < ApplicationController
  before_action :authenticate_user!

  def search
    @users = User.search_by_username(params[:term])
    @books = BooksElasticsearch.new.search(params[:term])
  end
end
