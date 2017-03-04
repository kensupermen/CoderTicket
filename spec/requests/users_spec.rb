require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /users" do
    it "works! (now write some real specs)" do
      get users_index_path
      expect(response).to have_http_status(200)
    end
  end
  
  describe "GET /sign_up" do
    it "Sign Up success" do
      visit sign_up_path
      expect(page).to include "sign up success"
    end
  end
end
