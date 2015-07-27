class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :is_same_user?, only: [:edit]

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.assign_attributes(user_params)
    if @user.valid?
      @user.save
      # render status: 200, json: @user
      redirect_to user_path(@user)
      return
    end
    render :edit
  end

  def search
    @users = User.where("username LIKE ?", "%#{params[:term]}%")
    render :search
  end

  private

  def user_params
    params.require(:user).permit(:bio, :latitude, :longitude, :avatar)
  end
end
