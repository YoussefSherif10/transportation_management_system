require 'rails_helper'

RSpec.describe V1::AuthenticationController, type: :controller do
  describe "POST #register" do
    let(:valid_attributes) { { email: "test@example.com", password: "password123" } }

    it "creates a new driver" do
      expect {
        post :register, params: valid_attributes
      }.to change(Driver, :count).by(1)
    end

    it "returns a token" do
      post :register, params: valid_attributes
      expect(JSON.parse(response.body)).to have_key("token")
    end
  end

  describe "POST #login" do
    let!(:driver) { create(:driver, email: "test@example.com", password: "password123") }

    it "returns a token for valid credentials" do
      post :login, params: { email: "test@example.com", password: "password123" }
      expect(JSON.parse(response.body)).to have_key("token")
    end

    it "returns unauthorized for invalid credentials" do
      post :login, params: { email: "test@example.com", password: "wrongpassword" }
      expect(response).to have_http_status(:unauthorized)
    end
  end
end