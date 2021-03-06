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
    @events = Event.search_by_name(params[:search])
    render 'index'
  end

  def create
    @event = Event.create event_params
    if @event.save
      flash[:success] = "Create success"
      redirect_to preview_event_path(@event.id)
    else
      flash[:error] = "Create error"
      redirect_to new_event_path
    end
  end

  def edit
    @event = Event.find_by id: params[:id]
    @venues = Venue.all
    @categories = Category.all
  end

  def update
    @event = Event.find_by id: params[:id]
    @event.update event_params
    redirect_to list_events_path
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
    ticket_type = TicketType.find_by event_id: @event.id
    if ticket_type == nil
      flash[:error] = "Please create ticket type first"
      redirect_to new_event_ticket_type_path(@event) and return
    end
    @event.update published_at: Time.now
    redirect_to event_path(@event)
  end

  private
  def event_params
    params.require(:event).permit(:name, :category_id, :venue_id, :hero_imag_url, :extended_html_description, :starts_at, :ends_at, :creator_id)
  end
end
