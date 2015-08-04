class LikedGenresController < ApplicationController
  def create
    if params[:liked_genres_ids]
      @user = User.find(params[:user_id])
      LikedGenre.where(user_id: @user.id).destroy_all
      @user.liked_genres = params[:liked_genres_ids].map do |genre_id|
        LikedGenre.create(genre_id: genre_id, user_id: @user.id)
      end
      @user.save
      render status: 201, json: @user
      return
    end
    render status: 400, body: "Error"
  end
end
