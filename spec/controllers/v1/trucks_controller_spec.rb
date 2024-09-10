require 'rails_helper'

RSpec.describe V1::TrucksController, type: :controller do
  let(:driver) { create(:driver) }
  let(:token) { JsonWebToken.jwt_encode(driver_id: driver.id) }

  before do
    request.headers['Authorization'] = token
  end

  describe "GET #index" do
    before { create_list(:truck, 5) }

    it "returns a list of trucks" do
      get :index
      expect(JSON.parse(response.body)['data'].size).to eq(5)
    end
  end

  describe "POST #assign_driver" do
    let(:truck) { create(:truck) }

    it "assigns a truck to the current driver" do
      post :assign_driver, params: { id: truck.id }
      expect(driver.trucks).to include(truck)
    end
  end

  describe "GET #assigned_trucks" do
    before do
      3.times { driver.trucks << create(:truck) }
    end

    it "returns a list of trucks assigned to the current driver" do
      get :assigned_trucks
      expect(JSON.parse(response.body)['data'].size).to eq(3)
    end
  end
end