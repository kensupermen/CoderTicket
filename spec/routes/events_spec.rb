require 'rails_helper'

RSpec.describe "events", type: :routing do
	it "routes /upcoming to events#index" do
		expect(get: "/upcoming").to route_to(controller: "events", action: "index")
	end

	it "routes /sign_up to users#new" do
		expect(get: "/sign_up").to route_to(controller: "users", action: "new")
	end
end
