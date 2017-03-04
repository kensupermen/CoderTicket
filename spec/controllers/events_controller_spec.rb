require 'rails_helper'

RSpec.describe EventsController, type: :controller do

	it "gets index" do
		get 'index'
		expect(response).to be_success
	end

  it "search events" do
    expect(get: '/search_events').to route_to(controller: "events", action: "search")
  end
end
