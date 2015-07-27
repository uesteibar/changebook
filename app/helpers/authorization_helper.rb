module AuthorizationHelper
  def authorize_user
    unless current_user.id == params[:id].to_i
      flash[:warning] = "That\'s out of your bounds."
      redirect_to "/"
    end
  end
end
