class ThanksController < ApplicationController
  before_action :authenticate_user!

  def create
    recommendation = Recommendation.find(params[:id])
    recommendation.thanks.create(user: current_user)
    render status: 201, json: recommendation
  end
end
