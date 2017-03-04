class TicketTypesController < ApplicationController

  def new
    @ticket_type = TicketType.new
    @event = Event.find_by(id: params[:event_id])
  end

  def create
    @ticket_type = TicketType.create ticket_type_params
    redirect_to new_event_ticket_type_path
  end

  private 
  def ticket_type_params
    params.require(:ticket_type).permit(:name, :price, :max_quantity, :event_id)
  end
end
