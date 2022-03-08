require 'rails_helper'

RSpec.describe Roadtrip, :vcr, type: :poro do
  context 'object properties' do
    let!(:forecast_data) { ForecastService.get_forecast(39.738453, -104.984853, 'imperial') }
    let!(:route_data) { RoadtripService.get_route('fortcollins,co', 'denver,co', 'm')[:route] }
  
    let!(:roadtrip) { Roadtrip.new('fortcollins,co', 'denver,co', route_data, forecast_data) }

    it 'exists' do
      expect(roadtrip).to be_a(Roadtrip)
    end

    it 'has attributes' do
      expect(roadtrip.id).to eq(nil)
      expect(roadtrip).to have_attributes(id: nil)

      expect(roadtrip.start_city).to be_a(String)
      expect(roadtrip).to have_attributes(start_city: 'Fort Collins, CO')
      
      expect(roadtrip.end_city).to be_a(String)
      expect(roadtrip).to have_attributes(end_city: 'Denver, CO')
      
      expect(roadtrip.travel_time).to be_a(String)
      expect(roadtrip).to have_attributes(travel_time: '1 hour(s), 2 min(s)')
      
      expect(roadtrip.weather_at_eta).to be_a(Hash)
      expect(roadtrip.weather_at_eta[:temperature]).to be_a(Float)
      expect(roadtrip.weather_at_eta[:conditions]).to be_a(String)
      expect(roadtrip.weather_at_eta.count).to eq(2)

      expected_weather = { temperature: 34.36, conditions: 'clear sky'}
      
      expect(roadtrip).to have_attributes(weather_at_eta: expected_weather)
    end
  end

  context 'given impossible route' do
    let!(:location) { ForecastService.get_city_lat_lon('london,uk') }
    let!(:lat) { location[:results][0][:locations][0][:latLng][:lat] }
    let!(:lng) { location[:results][0][:locations][0][:latLng][:lng] }

    let!(:forecast_data) { ForecastService.get_forecast(lat, lng, 'imperial') }
    let!(:route_data) { RoadtripService.get_route('denver,co', 'london,uk', 'm')[:route] }
  
    let!(:roadtrip) { Roadtrip.new('denver,co', 'london,uk', route_data, forecast_data) }

    it 'should return impossible time, and empty weather' do
      expect(roadtrip.id).to eq(nil)
      expect(roadtrip).to have_attributes(id: nil)

      expect(roadtrip.start_city).to be_a(String)
      expect(roadtrip).to have_attributes(start_city: 'denver,co')
      
      expect(roadtrip.end_city).to be_a(String)
      expect(roadtrip).to have_attributes(end_city: 'london,uk')
      
      expect(roadtrip.travel_time).to be_a(String)
      expect(roadtrip).to have_attributes(travel_time: 'impossible')
      
      expect(roadtrip.weather_at_eta).to be_a(Hash)
      expect(roadtrip.weather_at_eta).to be_empty
      expect(roadtrip.weather_at_eta.count).to eq(0)
    end
  end
end
