class ThanksController < ApplicationController
  before_action :authenticate_user!

  def create
    recommendation = Recommendation.find(params[:id])
    recommendation.thanks.create(user: current_user)
    recommendation.user.notifications.create(message: "#{current_user.username} thanked your recommendation of #{recommendation.book.title}")
    render status: 201, json: recommendation.thanks.count
  end
end
