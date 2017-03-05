class TicketsController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
  end

  def create
    @event = Event.find_by(id: params[:event_id])
    @order= Order.new(event: @event)

    ticket_quantity = params[:ticket_quantity]
    total_price_calc = 0;
    if ticket_quantity.count > 10 
      flash[:error] = "Can not buy more than 10 ticket"
      render 'new' and return
    render 
    end
    ticket_quantity.each do |ticket_type_id, quantity|
      ticket_type = TicketType.select(:id, :price, :max_quantity).find_by(id: ticket_type_id)
      if ticket_type.max_quantity < quantity.to_i
        flash[:error] = "Full"
        render 'new' and return
      end
      total_price_calc = total_price_calc + ticket_type.price * quantity.to_i
      order_detail = OrderDetail.new ticket_type_id: ticket_type_id, quantity: quantity
      @order.order_details << order_detail 
    end
    
    @order.total_price = total_price_calc
    if @order.save
      flash[:success] = "Buy success"
      redirect_to root_path
    else
      flash[:error] = @order.errors.full_messages.to_sentence
      redirect_to new_event_ticket_path
    end
  end

end
