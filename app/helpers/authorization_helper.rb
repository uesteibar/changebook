module AuthorizationHelper
  def authorize_user
    unless [params[:id].to_i, params[:user_id].to_i].include? current_user.id
      flash[:warning] = "That\'s out of your bounds."
      redirect_to "/"
    end
  end
end
