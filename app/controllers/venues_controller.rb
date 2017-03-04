class VenuesController < ApplicationController
  def new
    @venue = Venue.new
  end

  def create
    @venue = Venue.create venue_params
    redirect_to new_venue_path
  end

  private
  def venue_params
    params.require(:venue).permit(:name, :full_address)
  end
end
