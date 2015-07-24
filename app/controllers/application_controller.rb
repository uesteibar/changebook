class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :is_same_user

  def is_same_user?
    unless current_user.id == params[:id].to_i
      flash[:warning] = "That\'s out of your bounds."
      redirect_to "/"
    end
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :username
  end
end
