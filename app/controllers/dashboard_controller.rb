class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @events = current_user.events_by_date
    @system_recommendations = BookRecommendations.new.generate(user: current_user)
  end
end
