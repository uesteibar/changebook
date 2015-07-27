class FollowingsController < ApplicationController
  before_action :authenticate_user!

  def create
    current_user.follow(User.find(params[:id]))
    render status: 201, json: "created"
  end

  def destroy
    current_user.unfollow(User.find(params[:id]))
    render status: 200, json: "destroyed"
  end
end
