class EventsController < ApplicationController
  def index
    @events = Event.published
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
    @venues = Venue.all
    @categories = Category.all
  end

  def search
    @events = Event.where("name LIKE ?", "%#{params[:search]}%")
    render 'index'
  end

  def create
    @event = Event.create event_params
    if @event.save
      redirect_to preview_event_path(@event.id)
    else
      redirect_to new_event_path
    end
  end

  def list
    @events = current_user.events
  end

  def preview
    @event = Event.find_by(id: params[:id], creator_id: current_user.id)
    if @event == nil
      redirect_to root_path
    end
  end

  def publish
    @event = Event.find_by(id: params[:id], creator_id: current_user.id)
    @event.update published_at: Time.now
    redirect_to event_path(@event)
  end

  private
  def event_params
    params.require(:event).permit(:name, :category_id, :venue_id, :hero_imag_url, :extended_html_description, :starts_at, :ends_at, :creator_id)
  end
end
