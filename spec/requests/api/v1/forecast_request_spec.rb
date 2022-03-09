require 'rails_helper'

RSpec.describe 'Forecast Request API', :vcr, type: :request do
  context '#index action' do
    it 'returns a successful status when given valid location' do
      get api_v1_forecast_path(params: { location: 'denver,co' })

      expect(response).to be_successful
    end
    
    it 'returns parsable json data response for forecast' do
      get api_v1_forecast_path(params: { location: 'denver,co' })
      
      expect(json_parse(response.body)).to be_a(Hash)
    end
    
    it 'returns correct response attribute fields' do
      get api_v1_forecast_path(params: { location: 'denver,co' })
      hash = json_parse(response.body)
      attr = hash[:data][:attributes]

      expect(hash).to have_key(:data)
      expect(hash[:data]).to have_key(:id)
      expect(hash[:data][:id]).to eq(nil)
      expect(hash[:data][:type]).to eq('forecast')

      expect(attr).to have_key(:current_weather)
      expect(attr).to have_key(:daily_weather)
      expect(attr).to have_key(:hourly_weather)

      expect(attr[:current_weather]).to have_key(:datetime)
      expect(attr[:current_weather]).to have_key(:sunrise)
      expect(attr[:current_weather]).to have_key(:sunset)
      expect(attr[:current_weather]).to have_key(:temperature)
      expect(attr[:current_weather]).to have_key(:feels_like)
      expect(attr[:current_weather]).to have_key(:humidity)
      expect(attr[:current_weather]).to have_key(:uvi)
      expect(attr[:current_weather]).to have_key(:visibility)
      expect(attr[:current_weather]).to have_key(:conditions)
      expect(attr[:current_weather]).to have_key(:icon)

      expect(attr[:daily_weather].count).to eq(5)

      attr[:daily_weather].each do |day|
        expect(day).to have_key(:date)
        expect(day).to have_key(:sunrise)
        expect(day).to have_key(:sunset)
        expect(day).to have_key(:max_temp)
        expect(day).to have_key(:min_temp)
        expect(day).to have_key(:conditions)
        expect(day).to have_key(:icon)
      end

      expect(attr[:hourly_weather].count).to eq(8)
      
      attr[:hourly_weather].each do |hour|
        expect(hour).to have_key(:time)
        expect(hour).to have_key(:temperature)
        expect(hour).to have_key(:conditions)
        expect(hour).to have_key(:icon)
      end
    end

    it 'returns error messages in the hash with bad request status' do
      get api_v1_forecast_path(params: { location: 'zzzzzzzzzz' })
      expected_error = { errors: [ { status: 400, title: 'Bad Request' }] }
      hash = json_parse(response.body)
      attr = hash[:data][:attributes]

      expect(response.status).to eq(400)

      expect(hash).to have_key(:data)
      expect(hash[:data]).to have_key(:id)
      expect(hash[:data][:id]).to eq(nil)
      expect(hash[:data][:type]).to eq('forecast')

      expect(attr).to have_key(:current_weather)
      expect(attr).to have_key(:daily_weather)
      expect(attr).to have_key(:hourly_weather)
      
      expect(attr[:current_weather]).to eq(expected_error)
      expect(attr[:daily_weather]).to eq(expected_error)
      expect(attr[:hourly_weather]).to eq(expected_error)
    end
  end
end