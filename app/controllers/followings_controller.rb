class FollowingsController < ApplicationController
  before_action :authenticate_user!

  def create
    user_to_follow = User.find(params[:id])
    current_user.follow(user_to_follow)
    user_to_follow.notifications.create(message: "#{current_user.username} followed you.")
    render status: 201, body: "created"
  end

  def destroy
    user_to_unfollow = User.find(params[:id])
    current_user.unfollow(user_to_unfollow)
    render status: 200, body: "destroyed"
  end
end
