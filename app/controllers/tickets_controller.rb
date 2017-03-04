class TicketsController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
  end

  def create
    @event = Event.find_by(id: params[:event_id])
    @order= Order.new(event: @event)

    ticket_quantity = params[:ticket_quantity]
    total_price_calc = 0;
    ticket_quantity.each do |ticket_type_id, quantity|
      ticket_type = TicketType.select(:id, :price).find_by(id: ticket_type_id)
      total_price_calc = total_price_calc + ticket_type.price * quantity.to_i
      total_price =  
      order_detail = OrderDetail.new ticket_type_id: ticket_type_id, quantity: quantity
      @order.order_details << order_detail 
    end
    
    @order.total_price = total_price_calc
    if @order.save
      flash.now[:success] = "Buy success"
      redirect_to root_path
    else
      flash[:error] = @order.errors.full_messages.to_sentence
      redirect_to new_event_ticket_path
    end
  end

end
