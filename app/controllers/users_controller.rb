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
      redirect_to action: :show
      return
    end
    render :edit
  end

  private

  def user_params
    params.require(:user).permit(:bio)
  end
end
