class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @following = current_user.following?(@user)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.assign_attributes(user_params)
    if @user.valid?
      @user.save
      redirect_to user_path(@user)
      return
    end

    render :edit
  end

  private

  def user_params
    params.require(:user).permit(:bio, :latitude, :longitude, :avatar)
  end
end
