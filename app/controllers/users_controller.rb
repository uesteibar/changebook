class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :is_same_user?, only: [:edit]

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end
end
