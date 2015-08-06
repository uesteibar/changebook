class DashboardController < ApplicationController
  before_action :authenticate_user!

  def index
    @events = current_user.events_by_date.limit(20)
    @users_to_follow = []
    unless current_user.following.any?
      5.times do
        @users_to_follow << User.all.sample
      end
    end
    @system_recommendations = BookRecommendations.new.generate(user: current_user)
  end
end
