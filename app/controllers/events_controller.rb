class EventsController < ApplicationController
  before_action :authenticate_user!

  def index
    @events = current_user.events_by_date
  end
end
