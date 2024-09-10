require 'rails_helper'

RSpec.describe FetchTrucksJob, type: :job do
  describe '#perform' do
    let(:mock_response) do
      [
        { 'id' => 1, 'name' => 'Truck 1', 'truck_type' => 'Flatbed', 'created_at' => Time.now.iso8601 },
        { 'id' => 2, 'name' => 'Truck 2', 'truck_type' => 'Box', 'created_at' => Time.now.iso8601 }
      ]
    end

    before do
      allow(HTTParty).to receive(:get).and_return(double(code: 200, body: mock_response.to_json, headers: { 'total-pages' => '1' }))
    end

    it 'fetches and saves trucks' do
      expect { FetchTrucksJob.new.perform }.to change(Truck, :count).by(2)
    end

    it 'updates existing trucks' do
      existing_truck = create(:truck, id: 1, name: 'Old Name')
      FetchTrucksJob.new.perform
      expect(existing_truck.reload.name).to eq('Truck 1')
    end
  end
end