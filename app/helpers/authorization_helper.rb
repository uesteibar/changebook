module AuthorizationHelper
  def authorize_user
    unless params[:id].to_i == current_user.id
      flash[:warning] = "That\'s out of your bounds."
      redirect_to "/"
    end
  end
end
