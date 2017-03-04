class EventsController < ApplicationController
  def index
    #@events = Event.all
    @events = Event.where("name LIKE ?", "%#{params[:search]}%")
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
  end

  def search
    @events = Event.where("name LIKE ?", "%#{params[:search]}%")
    #redirect_to events_path
    render 'index'
  end
end
