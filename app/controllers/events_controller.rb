class EventsController < ApplicationController
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def search
    @events = Event.where(id: 1)
    redirect_to new_event_path
  end
end
